import 'package:chafi/view/screen/Calculators/different/TouristVehicles/TouristCehiclesCost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../view/screen/Calculators/different/TouristVehicles/ShwototalTouristVehicles.dart';

class Touristcehiclescontroller extends GetxController {
  String? fromPage;
  int type = 0;
  TextEditingController nameguidance = TextEditingController();
  TextEditingController costsguidance = TextEditingController();

  // Map لتخزين الهدايا: اسم → قيمة
  Map<String, int> gifts = {};

  double total = 0;
  double addreselttax = 0;
  double netTax = 0;

  void selectedPerson(int i) {
    type = i;
    update();
  }

  void gotodatacreate() {
    if (type == 0) {
      return showSnackbar("خطأ".tr, "إختر نوع الحساب".tr, Colors.red);
    }
    Get.to(Touristcehiclescost());
  }

  // حساب قيمة الهدايا إذا تجاوزت 1000
  int costsRental(int cost) {
    return cost > 20000000 ? cost - 20000000 : 0;
  }

  int costsmaintenance(int cost) {
    return cost > 2000000 ? cost - 2000000 : 0;
  }

  void addGuidance() {
    String name = nameguidance.text.trim();
    String costText = costsguidance.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (name.isEmpty || costText.isEmpty) return;

    int cost = int.parse(costText);

    gifts[name] = cost; // حفظ الهدية

    netTax += type == 2
        ? costsRental(cost.toInt())
        : costsmaintenance(cost.toInt());

    nameguidance.clear();
    costsguidance.clear();

    update();
  }

  void calcul() {
    if (gifts.isEmpty) {
      return showSnackbar("خطأ".tr, "لا يوجد مركبات".tr, Colors.red);
    }
    total = 0;
    addreselttax = 0;
    netTax = 0; // مهم جدا

    for (var cost in gifts.values) {
      int deductible = type == 2
          ? (cost > 20000000 ? 20000000 : cost)
          : (cost > 2000000 ? 2000000 : cost);
      int nonDeductible = type == 2
          ? costsRental(cost)
          : costsmaintenance(cost);

      netTax += cost; // مجموع كل الهدايا
      total += deductible; // الجزء المقبول
      addreselttax += nonDeductible; // الجزء الواجب إضافته
    }

    update();
    Get.to(() => Shwototaltouristvehicles());
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

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
