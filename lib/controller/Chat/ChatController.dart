import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Crud.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/Remote/ChatData.dart';
import '../../data/model/ChatModel.dart';

/// المساعد الذكي: المحادثة الحالية + قائمة المحادثات المحفوظة
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

  /// المساعد يكتب...
  bool sending = false;

  bool _ok(dynamic response) =>
      handlingData(response) == Statusrequest.success &&
      response is Map &&
      (response['status'] == 1 || response['status'] == true);

  /// رسالة خطأ مفهومة للمستخدم:
  /// رسائل السيرفر العربية (الحد اليومي، لم يتم العثور على إجابة...) تُعرض كما هي،
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
    // رسالة السيرفر مفيدة إذا كانت جملة مكتوبة (بالعربية أو رسالة "No answer found")
    final readable = message.isNotEmpty &&
        !message.contains('Exception') &&
        (RegExp(r'[؀-ۿ]').hasMatch(message) ||
            message.startsWith('No answer') ||
            message.startsWith('Aucune'));
    return readable ? message : fallback.tr;
  }

  /// لا تبديل ولا حذف للمحادثة والمساعد يكتب، وإلا يُضاف الجواب لمحادثة أخرى
  bool _busy() {
    if (!sending) return false;
    showSnackbar("تنبيه".tr, "انتظر حتى يكمل ChafiBot الجواب".tr, Colors.orange);
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
      conversationsStatus =
          conversations.isEmpty ? Statusrequest.nodata : Statusrequest.success;
    } else {
      conversationsStatus = Statusrequest.failure;
    }
    update();
  }

  Future<void> openConversation(ChatConversationModel conversation) async {
    if (_busy()) return;
    current = conversation;
    messages = [];
    loadingMessages = true;
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
      showSnackbar(
          "خطأ".tr, _error(response, "تعذر تحميل المحادثة"), Colors.red);
    }
    update();
    _scrollToEnd();
  }

  void newConversation() {
    if (_busy()) return;
    current = null;
    messages = [];
    input.clear();
    update();
  }

  Future<void> send([String? text]) async {
    final message = (text ?? input.text).trim();
    if (message.isEmpty || sending) return;

    Crud.lastError = null;
    input.clear();
    // تظهر رسالة المستخدم فوراً، وتُحذف إذا فشل الإرسال
    final pending = ChatMessageModel(role: 'user', content: message);
    messages.add(pending);
    sending = true;
    update();
    _scrollToEnd();

    final response = await chatData.send(message, conversationId: current?.id);
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
      messages.add(ChatMessageModel.fromJson(data['message']));
    } else {
      messages.remove(pending);
      input.text = message; // حتى لا يضيع ما كتبه
      showSnackbar(
          "خطأ".tr,
          _error(response, "ChafiBot غير متاح حالياً، حاول لاحقاً"),
          Colors.red);
    }
    update();
    _scrollToEnd();
  }

  Future<void> rename(ChatConversationModel conversation, String title) async {
    title = title.trim();
    if (title.isEmpty || title == conversation.title) return;
    Crud.lastError = null;
    final response = await chatData.rename(conversation.id, title);
    if (_ok(response)) {
      conversation.title = title;
      update();
    } else {
      showSnackbar("خطأ".tr, _error(response, "فشل التعديل"), Colors.red);
    }
  }

  Future<void> delete(ChatConversationModel conversation) async {
    if (_busy()) return;
    Crud.lastError = null;
    final response = await chatData.delete(conversation.id);
    if (_ok(response)) {
      conversations.removeWhere((c) => c.id == conversation.id);
      if (conversations.isEmpty) conversationsStatus = Statusrequest.nodata;
      if (current?.id == conversation.id) newConversation();
      update();
    } else {
      showSnackbar("خطأ".tr, _error(response, "فشل الحذف"), Colors.red);
    }
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
    input.dispose();
    scroll.dispose();
    super.onClose();
  }
}
