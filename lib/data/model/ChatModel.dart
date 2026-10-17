/// محادثة محفوظة مع المساعد الذكي
class ChatConversationModel {
  final int id;
  String title;
  final DateTime? updatedAt;

  ChatConversationModel({required this.id, required this.title, this.updatedAt});

  factory ChatConversationModel.fromJson(Map json) => ChatConversationModel(
        id: int.parse(json['id'].toString()),
        title: (json['title'] ?? '').toString(),
        updatedAt: DateTime.tryParse((json['updated_at'] ?? '').toString()),
      );
}

/// مصدر الجواب: مادة / نظام جبائي / جزاءات / مؤسسة / سؤال شائع / موعد / نشاط / مقال
class ChatSourceModel {
  final String type;
  final int id;
  final String title;
  final String? number;
  final String? document;

  /// نص المصدر (يُعرض عند الضغط عليه)
  final String? content;

  ChatSourceModel({
    required this.type,
    required this.id,
    required this.title,
    this.number,
    this.document,
    this.content,
  });

  bool get isArticle => type == 'article';

  factory ChatSourceModel.fromJson(Map json) => ChatSourceModel(
        type: (json['type'] ?? '').toString(),
        id: int.parse(json['id'].toString()),
        title: (json['title'] ?? '').toString(),
        number: json['number']?.toString(),
        document: json['document']?.toString(),
        content: json['content']?.toString(),
      );
}

class ChatMessageModel {
  final int? id;
  final String role; // user / assistant / error (فشل محلي، لا يُحفظ)
  final String content;
  final List<ChatSourceModel> sources;
  final List<String> calculations;

  /// مواضيع مقترحة عندما لا يفهم المساعد السؤال (يضغط عليها المستخدم)
  final List<String> options;

  /// وقت الرسالة (للعرض أسفل الفقاعة)
  final DateTime createdAt;

  /// رسالة فشل: السؤال الذي يُعاد إرساله بـ "إعادة المحاولة" (null = لا فائدة من الإعادة)
  final String? retryText;

  ChatMessageModel({
    this.id,
    required this.role,
    required this.content,
    this.sources = const [],
    this.calculations = const [],
    this.options = const [],
    this.retryText,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isUser => role == 'user';

  bool get isError => role == 'error';

  factory ChatMessageModel.fromJson(Map json) => ChatMessageModel(
        id: json['id'] == null ? null : int.parse(json['id'].toString()),
        role: (json['role'] ?? 'assistant').toString(),
        content: (json['content'] ?? '').toString(),
        createdAt:
            DateTime.tryParse((json['created_at'] ?? '').toString())?.toLocal(),
        sources: [
          for (final s in (json['sources'] as List? ?? []))
            if (s is Map) ChatSourceModel.fromJson(s),
        ],
        calculations: [
          for (final c in (json['calculations'] as List? ?? [])) c.toString(),
        ],
        options: [
          for (final o in (json['options'] as List? ?? [])) o.toString(),
        ],
      );
}
