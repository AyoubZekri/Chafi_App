import 'package:get/get.dart';

class MypathModel {
  final int id;
  final int userId;
  final int personType;
  final int? nataireActivityId;
  final int? activityId;
  final int taxId;
  final int? activitSpecial;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String username;
  final String wilaya;
  final String? activityName;
  final String? activityNameFr;
  final String? codeActivity;
  final String? nataireActivitysName;
  final String? nataireActivitysNameFr;

  MypathModel({
    required this.id,
    required this.userId,
    required this.personType,
    this.nataireActivityId,
    this.activityId,
    required this.taxId,
    this.activitSpecial,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.wilaya,
    this.activityName,
    this.activityNameFr,
    this.codeActivity,
    this.nataireActivitysName,
    this.nataireActivitysNameFr,
  });

  factory MypathModel.fromJson(Map<String, dynamic> json) {
    return MypathModel(
      id: json['id'],
      userId: json['user_id'],
      personType: json['person_type'],
      nataireActivityId: json['nataire_activity_id'],
      activityId: json['activity_id'],
      taxId: json['tax_id'],
      activitSpecial: json['activit_special'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      username: json['username'],
      wilaya: json['wilaya'],
      activityName: json['activity_name'],
      activityNameFr: json['activity_name_fr'],
      codeActivity: json['code_activity'],
      nataireActivitysName: json['nataire_activitys_name'],
      nataireActivitysNameFr: json['nataire_activitys_name_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'person_type': personType,
      'nataire_activity_id': nataireActivityId,
      'activity_id': activityId,
      'tax_id': taxId,
      'activit_special': activitSpecial,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'username': username,
      'wilaya': wilaya,
      'activity_name': activityName,
      'activity_name_fr': activityNameFr,
      'code_activity': codeActivity,
      'nataire_activitys_name': nataireActivitysName,
      'nataire_activitys_name_fr': nataireActivitysNameFr,
    };
  }

  MypathModel copyWith({
    int? id,
    int? userId,
    int? personType,
    int? nataireActivityId,
    int? activityId,
    int? taxId,
    int? activitSpecial,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    String? wilaya,
    String? activityName,
    String? activityNameFr,
    String? codeActivity,
    String? nataireActivitysName,
    String? nataireActivitysNameFr,
  }) {
    return MypathModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personType: personType ?? this.personType,
      nataireActivityId: nataireActivityId ?? this.nataireActivityId,
      activityId: activityId ?? this.activityId,
      taxId: taxId ?? this.taxId,
      activitSpecial: activitSpecial ?? this.activitSpecial,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      wilaya: wilaya ?? this.wilaya,
      activityName: activityName ?? this.activityName,
      activityNameFr: activityNameFr ?? this.activityNameFr,
      codeActivity: codeActivity ?? this.codeActivity,
      nataireActivitysName: nataireActivitysName ?? this.nataireActivitysName,
      nataireActivitysNameFr:
          nataireActivitysNameFr ?? this.nataireActivitysNameFr,
    );
  }

  String get localizedActivityName {
    final lang = Get.locale?.languageCode ?? 'ar';
    if (lang == 'ar') return activityName ?? '';
    return activityNameFr ?? '';
  }

  String get localizedNataireActivitysName {
    final lang = Get.locale?.languageCode ?? 'ar';
    if (lang == 'ar') return nataireActivitysName ?? '';
    return nataireActivitysNameFr ?? '';
  }

  /// Helper لتحويل JSON سواء كان عنصر واحد أو List
  static List<MypathModel> fromJsonList(dynamic jsonData) {
    if (jsonData is List) {
      return jsonData.map((e) => MypathModel.fromJson(e)).toList();
    } else if (jsonData is Map<String, dynamic>) {
      return [MypathModel.fromJson(jsonData)];
    } else {
      return [];
    }
  }
}
