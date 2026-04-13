import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/valiedinput.dart';

class Taxstampcontroller extends GetxController {
  String? tasStampsErorr;
  TextEditingController tasStamps = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

  calcul() {
    tasStampsErorr = validInput(tasStamps.text.replaceAll(RegExp(r'[^0-9]'), ''), 20, 1, "int");
    tasStamp = double.tryParse(tasStamps.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (tasStampsErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      if (tasStamp <= 3000000) {
        netTax = tasStamp * 0.01;
      } else if (tasStamp > 3000000 && tasStamp <= 10000000) {
        netTax = tasStamp * 0.015;
      } else if (tasStamp > 10000000) {
        netTax = tasStamp * 0.02;
      }

      if (netTax <= 500) {
        netTax = 500;
      }
    }
    update();
  }

  void Back() {
    tasStamps.clear();
    tasStampsErorr = null;
    netTax = 0;
    update();
    Get.back();
  }
}
