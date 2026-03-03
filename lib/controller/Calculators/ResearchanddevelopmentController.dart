import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/valiedinput.dart';

class Researchanddevelopmentcontroller extends GetxController {
  String? accountingprofitErorr;
  TextEditingController accountingprofit = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

  calcul() {
    accountingprofitErorr = validInput(
      accountingprofit.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    tasStamp =
        double.tryParse(
          accountingprofit.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (accountingprofitErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      netTax = tasStamp * 0.3;
    }
    update();
  }

  void Back() {
    accountingprofit.clear();
    accountingprofitErorr = null;
    netTax = 0;
    update();
    Get.back();
  }
}
