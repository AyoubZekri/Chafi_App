import 'package:get/get.dart';

class BonusModel {
  final int id;
  final String nameAr;
  final String nameFr;
  final int category;
  final bool isRequired;
  final String? type;
  final bool? hasSpecialLogic;
  final int? valueType;
  final int? actionType;

  BonusModel({
    required this.id,
    required this.nameAr,
    required this.nameFr,
    required this.category,
    required this.isRequired,
    this.type,
    this.hasSpecialLogic,
    this.valueType,
    this.actionType,
  });

  factory BonusModel.fromJson(Map<String, dynamic> json) {
    return BonusModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameFr: json['name_fr'],
      category: json['category'],
      isRequired: json['is_required'] == 1,
      type: json['type'],
      hasSpecialLogic: json['has_special_logic'] != null
          ? json['has_special_logic'] == 1
          : null,
      valueType: json['value_type'],
      actionType: json['action_type'],
    );
  }

  String get localizedName {
    final lang = Get.locale?.languageCode ?? 'ar';
    return lang == 'ar' ? nameAr : nameFr;
  }
}
