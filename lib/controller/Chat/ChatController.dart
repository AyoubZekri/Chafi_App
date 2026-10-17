import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Crud.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/Remote/ChatData.dart';
import '../../data/model/ChatModel.dart';

/// المساعد الذكي: المحادثة الحالية + قائمة المحادثات المحفوظة.
/// لا رسائل snackbar: فشل الإرسال يظهر كرسالة في المحادثة مع "إعادة المحاولة"،
/// وفشل تحميل المحادثة بـ Handlingview، والتنبيهات القصيرة في شريط فوق الحقل
class ChatController extends GetxController {
  final ChatData chatData = ChatData(Get.find());
  final TextEditingController input = TextEditingController();
  final ScrollController scroll = ScrollController();

  List<ChatConversationModel> conversations = [];
  Statusrequest conversationsStatus = Statusrequest.none;

  /// null = محادثة جديدة لم تُرسل فيها رسالة بعد
  ChatConversationModel? current;
  List<ChatMessageModel> messages = [];
  bool loadingMessages = false;

  /// حالة تحميل رسائل المحادثة المفتوحة (فشل ← Handlingview)
  Statusrequest messagesStatus = Statusrequest.success;

  /// المساعد يكتب...
  bool sending = false;

  /// تنبيه قصير يظهر فوق حقل الكتابة ثم يختفي (بدل snackbar)
  String? notice;
  Timer? _noticeTimer;

  bool _ok(dynamic response) =>
      handlingData(response) == Statusrequest.success &&
      response is Map &&
      (response['status'] == 1 || response['status'] == true);

  /// رسالة خطأ مفهومة للمستخدم:
  /// رسائل السيرفر العربية (الحد اليومي...) تُعرض كما هي،
  /// وأخطاء الشبكة والمهلة وصفحات HTML تُستبدل بجملة واضحة
  String _error(dynamic response, String fallback) {
    if (response == Statusrequest.serverfailure) {
      return "تحقق من اتصالك بالإنترنت".tr;
    }
    final text = Crud.lastError ?? '';
    final code = Crud.lastStatusCode;
    if (text.contains('TimeoutException') || code == 504 || code == 524) {
      return "ChafiBot تأخر في الرد، حاول مرة أخرى".tr;
    }
    if (code == 401) return "انتهت الجلسة، سجّل الدخول من جديد".tr;
    // الخدمة متوقفة: رسالة التطبيق دائماً (بلغة المستخدم) مهما كان نص السيرفر
    if (code == 502 || code == 503) {
      return "ChafiBot غير متاح حالياً، حاول لاحقاً".tr;
    }
    final message = text.replaceFirst(RegExp(r'^\d{3}:\s*'), '').trim();
    // رسالة السيرفر مفيدة إذا كانت جملة مكتوبة بالعربية
    final readable =
        message.isNotEmpty &&
        !message.contains('Exception') &&
        RegExp(r'[؀-ۿ]').hasMatch(message);
    return readable ? message : fallback.tr;
  }

  /// إعادة المحاولة لا تفيد في الحد اليومي ولا في انتهاء الجلسة
  /// (ولا في "لم يتم العثور على إجابة" 422 من نسخة السيرفر القديمة)
  bool get _canRetry => ![429, 401, 422].contains(Crud.lastStatusCode);

  void _showNotice(String text) {
    notice = text;
    _noticeTimer?.cancel();
    _noticeTimer = Timer(const Duration(seconds: 3), () {
      notice = null;
      update();
    });
    update();
  }

  /// لا تبديل ولا حذف للمحادثة والمساعد يكتب، وإلا يُضاف الجواب لمحادثة أخرى
  bool _busy() {
    if (!sending) return false;
    _showNotice("انتظر حتى يكمل ChafiBot الجواب".tr);
    return true;
  }

  Future<void> loadConversations() async {
    conversationsStatus = Statusrequest.loadeng;
    update();
    final response = await chatData.conversations();
    if (_ok(response)) {
      conversations = [
        for (final c in (response['data'] as List? ?? []))
          ChatConversationModel.fromJson(c),
      ];
      conversationsStatus = conversations.isEmpty
          ? Statusrequest.nodata
          : Statusrequest.success;
    } else {
      // بدون إنترنت أو خطأ: يعرضهما Handlingview
      conversationsStatus = response == Statusrequest.serverfailure
          ? Statusrequest.serverfailure
          : Statusrequest.failure;
    }
    update();
  }

  Future<void> openConversation(ChatConversationModel conversation) async {
    if (_busy()) return;
    current = conversation;
    messages = [];
    editing = null;
    loadingMessages = true;
    messagesStatus = Statusrequest.success;
    Crud.lastError = null;
    update();
    final response = await chatData.messages(conversation.id);
    loadingMessages = false;
    if (_ok(response)) {
      messages = [
        for (final m in (response['data'] as List? ?? []))
          ChatMessageModel.fromJson(m),
      ];
    } else {
      messagesStatus = response == Statusrequest.serverfailure
          ? Statusrequest.serverfailure
          : Statusrequest.failure;
    }
    update();
    _scrollToEnd();
  }

  /// إعادة تحميل المحادثة المفتوحة (بعد فشل التحميل)
  Future<void> reloadConversation() async {
    if (current != null) await openConversation(current!);
  }

  void newConversation() {
    if (_busy()) return;
    current = null;
    messages = [];
    editing = null;
    messagesStatus = Statusrequest.success;
    input.clear();
    update();
  }

  /// سؤال سابق قيد التعديل (مثل ChatGPT): عند الإرسال يُستبدل هو وكل ما بعده
  ChatMessageModel? editing;

  void startEdit(ChatMessageModel message) {
    if (_busy() || message.id == null || current == null) return;
    editing = message;
    input.text = message.content;
    input.selection = TextSelection.collapsed(offset: input.text.length);
    update();
  }

  void cancelEdit() {
    editing = null;
    input.clear();
    update();
  }

  Future<void> send([String? text]) async {
    final message = (text ?? input.text).trim();
    if (message.isEmpty || sending) return;

    Crud.lastError = null;
    input.clear();
    // رسائل الفشل السابقة وأسئلتها غير المحفوظة لم تعد لازمة
    messages.removeWhere((m) => m.isError || (m.isUser && m.id == null));

    // التعديل: نخفي السؤال القديم وما بعده فوراً، ونرجعه إذا فشل الإرسال
    final edited = editing;
    final editIndex = edited == null ? -1 : messages.indexOf(edited);
    final before = List<ChatMessageModel>.from(messages);
    editing = null;
    if (editIndex >= 0) messages = messages.sublist(0, editIndex);

    // تظهر رسالة المستخدم فوراً
    final pending = ChatMessageModel(role: 'user', content: message);
    messages.add(pending);
    sending = true;
    update();
    _scrollToEnd();

    final response = editIndex >= 0
        ? await chatData.edit(current!.id, edited!.id!, message)
        : await chatData.send(message, conversationId: current?.id);
    sending = false;

    if (_ok(response)) {
      final data = response['data'] as Map;
      final conversation = ChatConversationModel.fromJson(data['conversation']);
      if (current == null) {
        current = conversation;
        conversations.insert(0, conversation);
        conversationsStatus = Statusrequest.success;
      } else {
        // المحادثة الحالية تصعد إلى أعلى القائمة
        conversations.removeWhere((c) => c.id == conversation.id);
        conversations.insert(0, current!);
      }
      // سؤال السيرفر (برقمه) مكان المؤقت، حتى يمكن تعديله لاحقاً
      if (data['user_message'] is Map) {
        final index = messages.indexOf(pending);
        if (index >= 0) {
          messages[index] = ChatMessageModel.fromJson(data['user_message']);
        }
      }
      messages.add(ChatMessageModel.fromJson(data['message']));
    } else {
      final error = _error(response, "ChafiBot غير متاح حالياً، حاول لاحقاً");
      if (editIndex >= 0) {
        // فشل التعديل: يرجع كل شيء كما كان، والسؤال يبقى قيد التعديل
        messages = before;
        editing = edited;
        input.text = message;
      }
      // الفشل كجواب من ChafiBot (لا snackbar)، مع إعادة المحاولة إن كانت تفيد
      messages.add(
        ChatMessageModel(
          role: 'error',
          content: error,
          retryText: _canRetry ? message : null,
        ),
      );
    }
    update();
    _scrollToEnd();
  }

  /// "إعادة المحاولة" في رسالة الفشل: تُحذف هي وسؤالها غير المحفوظ ثم يُعاد الإرسال
  Future<void> retry(ChatMessageModel failed) async {
    if (sending || failed.retryText == null) return;
    messages.remove(failed);
    await send(failed.retryText);
  }

  /// يرجع رسالة الخطأ، أو null إذا نجح
  Future<String?> rename(
    ChatConversationModel conversation,
    String title,
  ) async {
    title = title.trim();
    if (title.isEmpty || title == conversation.title) return null;
    Crud.lastError = null;
    final response = await chatData.rename(conversation.id, title);
    if (_ok(response)) {
      conversation.title = title;
      update();
      return null;
    }
    return _error(response, "فشل التعديل");
  }

  /// يرجع رسالة الخطأ، أو null إذا نجح
  Future<String?> delete(ChatConversationModel conversation) async {
    if (sending) return "انتظر حتى يكمل ChafiBot الجواب".tr;
    Crud.lastError = null;
    final response = await chatData.delete(conversation.id);
    if (_ok(response)) {
      conversations.removeWhere((c) => c.id == conversation.id);
      if (conversations.isEmpty) conversationsStatus = Statusrequest.nodata;
      if (current?.id == conversation.id) newConversation();
      update();
      return null;
    }
    return _error(response, "فشل الحذف");
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scroll.hasClients) return;
      scroll.animateTo(
        scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onInit() {
    loadConversations();
    super.onInit();
  }

  @override
  void onClose() {
    _noticeTimer?.cancel();
    input.dispose();
    scroll.dispose();
    super.onClose();
  }
}
