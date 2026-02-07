import 'package:get/get.dart';

class dataModel {
  final int id;
  final int typeInstitution;
  final int scope;
  final int index;
  final String title;
  final int catId;
  final String body;
  final String titleFr;
  final String bodyFr;
  final int? lawId;
  final String? indexLink;
  final String? calcul;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool? isread;
  final String pdf;

  dataModel({
    required this.id,
    required this.typeInstitution,
    required this.scope,
    required this.index,
    required this.title,
    required this.body,
    required this.titleFr,
    required this.bodyFr,
    this.lawId,
    this.indexLink,
    this.calcul,
    required this.createdAt,
    required this.updatedAt,
    required this.isread,
    required this.pdf,
    required this.catId,
  });

  factory dataModel.fromJson(Map<String, dynamic> json) {
    return dataModel(
      id: json['id'],
      typeInstitution: json['type_institution'] ?? 0,
      scope: json['scope'] ?? 0,
      index: json['index'],
      title: json['title'],
      body: json['body'] ?? "",
      catId: json['cat_id'] ?? 0,
      titleFr: json['title_fr'],
      bodyFr: json['body_fr'] ?? "",
      pdf: json['pdf'] ?? "",
      lawId: json['law_id'] ?? 0,
      indexLink: json['index_link'],
      calcul: json['calcul'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isread: json['is_read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_institution': typeInstitution,
      'scope': scope,
      'index': index,
      'title': title,
      'body': body,
      'title_fr': titleFr,
      'body_fr': bodyFr,
      'law_id': lawId,
      'pdf': pdf,
      'cat_id': catId,
      'index_link': indexLink,
      'calcul': calcul,
      'is_read': isread,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get localizedName {
    final lang = Get.locale?.languageCode ?? 'ar';
    return lang == 'ar' ? title : titleFr;
  }

  String get localizedBody {
    final lang = Get.locale?.languageCode ?? 'ar';
    return lang == 'ar' ? body : bodyFr;
  }
}
