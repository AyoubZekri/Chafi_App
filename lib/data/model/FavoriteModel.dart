import 'package:get/get.dart';

class FavoriteModel {
  final Map<String, dynamic> data;

  FavoriteModel(this.data);

  int get id => data['id'] ?? data['item_id'] ?? 0;
  int get type => int.tryParse(data['favorite_item_type']?.toString() ?? data['type']?.toString() ?? '0') ?? 0;
  
  String get title {
    String lang = Get.locale?.languageCode ?? 'ar';
    if (lang == 'ar') {
      return data['title'] ?? data['name_ar'] ?? data['name'] ?? '';
    } else {
      return data['title_fr'] ?? data['name_fr'] ?? data['name'] ?? data['title'] ?? '';
    }
  }

  String get body {
    String lang = Get.locale?.languageCode ?? 'ar';
    if (lang == 'ar') {
      return data['body'] ?? data['body_ar'] ?? '';
    } else {
      return data['body_fr'] ?? data['body'] ?? '';
    }
  }

  bool get hasCalcul => data['calcul'] != null;
  List<dynamic>? get laws => data['laws'];
}
