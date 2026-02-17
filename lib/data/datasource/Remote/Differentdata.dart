import 'package:get/get.dart';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';
import '../../../core/class/Sqldb.dart';
import '../../../core/services/Services.dart';

class Differentdata {
  Crud crud;
  Differentdata(this.crud);
  final SQLDB sqldb = SQLDB();
  final Myservices myservices = Get.find();

  bool get isLoggedIn =>
      myservices.sharedPreferences?.getString("token") != null;

  Future<Map<String, dynamic>> viewdata(Map data) async {
    Map<String, List<dynamic>> result = {"data": []};

    if (isLoggedIn) {
      var response = await crud.postWithheaders(Applink.differentShow, data);
      var body = response.fold((l) => l, (r) => r);

      if (body is Map && body.containsKey("data")) {
        result["data"] = body["data"];
      } else if (body is List) {
        result["data"] = body;
      }
    } else {
      var response = await crud.postWithheaders(
        Applink.differentShowNologin,
        data,
      );
      var body = response.fold((l) => l, (r) => r);

      List items = [];
      if (body is Map && body.containsKey("data")) {
        items = body["data"];
      } else if (body is List) {
        items = body;
      }

      // جلب البيانات المحلية للقراءات
      List<Map> localReads = await sqldb.read('read_differents');
      List<int> readIds = localReads
          .map((e) => e['different_id'] as int)
          .toList();

      // تعديل كل عنصر لوضع is_read
      items = items.map((item) {
        int id = item['id'] as int;
        item['is_read'] = readIds.contains(id) ? true : false;
        return item;
      }).toList();

      result["data"] = items;
    }

    return result;
  }

  Future<dynamic> isRead(int institutionId) async {
    if (isLoggedIn) {
      final response = await crud.postWithheaders(
        Applink.differentShowisReade,
        {"table_id": institutionId},
      );
      return response.fold((r) => r, (l) => l);
    } else {
      try {
        await sqldb.insert('read_differents', {
          "different_id": institutionId,
        });
        return {"status": 1, "message": "Success", "data": "تم الإنشاء بنجاح"};
      } catch (e) {
        print("خطأ في تسجيل القراءة محليًا: $e");
        return null;
      }
    }
  }
}
