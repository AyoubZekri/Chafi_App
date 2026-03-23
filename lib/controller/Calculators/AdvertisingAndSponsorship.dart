import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/valiedinput.dart';

class Advertisingandsponsorshipcontroller extends GetxController {
  String? BusinessnumberErorr;
  TextEditingController Businessnumber = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

  calcul() {
    BusinessnumberErorr = validInput(
      Businessnumber.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    tasStamp =
        double.tryParse(
          Businessnumber.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (BusinessnumberErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      netTax = tasStamp * 0.10;
    }
    update();
  }

  void Back() {
    Businessnumber.clear();
    BusinessnumberErorr = null;
    netTax = 0;
    update();
    Get.back();
  }
}
