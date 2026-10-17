import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

/// المساعد الذكي: المحادثات المحفوظة وإرسال الرسائل
class ChatData {
  Crud crud;
  ChatData(this.crud);

  conversations() async {
    var response = await crud.postWithheaders(Applink.chatConversations, {});
    return response.fold((l) => l, (r) => r);
  }

  messages(int conversationId) async {
    var response = await crud.postWithheaders(Applink.chatMessages, {
      "conversation_id": conversationId,
    });
    return response.fold((l) => l, (r) => r);
  }

  /// بدون [conversationId] تُنشأ محادثة جديدة.
  /// بدون حد زمني: ينتظر حتى يصل الجواب مهما طال البحث
  send(String message, {int? conversationId}) async {
    var response = await crud.postWithheaders(Applink.chatSend, {
      "message": message,
      if (conversationId != null) "conversation_id": conversationId,
    });
    return response.fold((l) => l, (r) => r);
  }

  /// تعديل سؤال سابق: يُستبدل هو وكل ما بعده بالسؤال الجديد وجوابه
  edit(int conversationId, int messageId, String message) async {
    var response = await crud.postWithheaders(Applink.chatEdit, {
      "conversation_id": conversationId,
      "message_id": messageId,
      "message": message,
    });
    return response.fold((l) => l, (r) => r);
  }

  rename(int conversationId, String title) async {
    var response = await crud.postWithheaders(Applink.chatRename, {
      "conversation_id": conversationId,
      "title": title,
    });
    return response.fold((l) => l, (r) => r);
  }

  delete(int conversationId) async {
    var response = await crud.postWithheaders(Applink.chatDelete, {
      "conversation_id": conversationId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
