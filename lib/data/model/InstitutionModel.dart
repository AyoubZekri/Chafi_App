import 'package:get/get.dart';
import 'LawModel.dart';

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
  final String? indexLink;
  final String? calcul;

  bool? isread;
  final List<dynamic>? laws;

  dataModel({
    required this.id,
    required this.typeInstitution,
    required this.scope,
    required this.index,
    required this.title,
    required this.body,
    required this.titleFr,
    required this.bodyFr,
    this.indexLink,
    this.calcul,

    required this.isread,
    required this.catId,
    this.laws,
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
      indexLink: json['index_link'],
      calcul: json['calcul'],
      isread: json['is_read'],
      laws: json['laws'],
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
      'cat_id': catId,
      'index_link': indexLink,
      'calcul': calcul,
      'is_read': isread,
      'laws': laws,
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
