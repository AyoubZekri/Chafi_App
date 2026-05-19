import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../view/screen/Calculators/different/guidance/Shwototalguidance.dart';

class Costsguidancecontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;

  TextEditingController nameguidance = TextEditingController();
  TextEditingController costsguidance = TextEditingController();

  // Map لتخزين الهدايا: اسم → قيمة
  Map<String, int> gifts = {};

  double total = 0;
  double addreselttax = 0;
  double netTax = 0;

  // حساب قيمة الهدايا إذا تجاوزت 1000
  int costsguidances(int cost) {
    return cost > 100000 ? cost - 100000 : 0;
  }

  void addGuidance() {
    String name = nameguidance.text.trim();
    String costText = costsguidance.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (name.isEmpty || costText.isEmpty) return;

    int cost = int.parse(costText);

    gifts[name] = cost; // حفظ الهدية

    netTax += costsguidances(cost); // إضافة القيمة بعد خصم أول 1000

    nameguidance.clear();
    costsguidance.clear();

    update();
  }

  void calcul() {
    if (gifts.isEmpty) {
      return showSnackbar("خطأ".tr, "لا يوجد هدايا".tr, Colors.red);
    }
    total = 0;
    addreselttax = 0;
    netTax = 0; // مهم جدا

    for (var cost in gifts.values) {
      int deductible = cost > 100000 ? 100000 : cost;
      int nonDeductible = costsguidances(cost);

      netTax += cost; // مجموع كل الهدايا
      total += deductible; // الجزء المقبول
      addreselttax += nonDeductible; // الجزء الواجب إضافته
    }

    update();
    Get.to(() => Shwototalguidance());
  }

  void Back() {
    nameguidance.clear();
    costsguidance.clear();
    netTax = 0;
    gifts.clear();
    update();
    Get.back();
  }

  void BackfromShow() {
    nameguidance.clear();
    costsguidance.clear();
    netTax = 0;
    total = 0;
    addreselttax = 0;
    update();
    Get.back();
  }

  void resetAll() {
    nameguidance.clear();
    costsguidance.clear();
    netTax = 0;
    gifts.clear();
    update();
    Get.until((route) => Get.currentRoute == fromPage);
  }

  Future<void> addenter(int type_stats) async {
    update();
    if (!await checkInternet()) {
      print("=======checkInternet false=====${await checkInternet()}");
      return;
    }
    var response = await postdata.adddata({
      'device_id': myServices.sharedPreferences?.getString('device_id'),
      "type_stats": type_stats,
    });
    print("=======================$response");
    statusrequest = handlingData(response);
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        print('==================enter+1');
        statusrequest = Statusrequest.success;
      }
    }
    update();
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    addenter(4);
    super.onInit();
  }
}
