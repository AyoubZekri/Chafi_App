import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Taxstampcontroller extends GetxController {
  TextEditingController tasStamps = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

  calcul() {
    tasStamp = double.tryParse(tasStamps.text) ?? 0;
    if (tasStamp <= 3000) {
      netTax = tasStamp * 0.01;
    } else if (tasStamp > 3000 && tasStamp <= 10000) {
      netTax = tasStamp * 0.015;
    } else if (tasStamp > 10000) {
      netTax = tasStamp * 0.02;
    }
    update();
  }

  void Back() {
    tasStamps.clear();
    netTax = 0;
    update();
    Get.back();
  }
}
