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
  /// المساعد قد يأخذ وقتاً (بحث + نموذج)، فالحد 4 دقائق بدل الانتظار بلا نهاية
  send(String message, {int? conversationId}) async {
    var response = await crud.postWithheaders(Applink.chatSend, {
      "message": message,
      if (conversationId != null) "conversation_id": conversationId,
    }, timeout: const Duration(minutes: 4));
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
