import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../view/screen/Calculators/different/InterestTax/InterestTaxType.dart';
import '../../view/screen/Calculators/different/InterestTax/ValuoTax.dart';

class Interesttaxcontroller extends GetxController {
  int typeTax = 0;
  int interesttaxtype = 0;
  String? frompage;
  String? fixedValueControllerError;
  double netTax = 0;
  double value = 0;

  TextEditingController fixedValueController = TextEditingController();

  void selectedtypeTax(int i) {
    typeTax = i;
    update();
  }

  void gotoInteresttaxtype() {
    print("===============$typeTax");
    if (typeTax == 0) {
      return showSnackbar("خطأ".tr, "الرجاء إختيار نوع الضريبة".tr, Colors.red);
    }
    Get.to(() => Interesttaxtype());
  }

  void selectedInteresttaxtype(int i) {
    interesttaxtype = i;
    update();
  }

  String text() {
    return typeTax == 1
        ? "إختيار نوع التنازل".tr
        : typeTax == 2
        ? "إختيار نوع الدخل".tr
        : "إختيار نوع الإيراد".tr;
  }

  void gotoValuotax() {
    if (interesttaxtype == 0) {
      return showSnackbar("خطأ".tr, "الرجاء ${text()}".tr, Colors.red);
    }
    Get.to(() => Valuotax());
  }

  void calcul() {
    fixedValueControllerError = validInput(
      fixedValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      3,
      "int",
    );
    value =
        double.tryParse(
          fixedValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (fixedValueControllerError == null) {
      if (typeTax == 1) {
        if (interesttaxtype == 1 || interesttaxtype == 2) {
          netTax = value * 0.15;
        } else {
          netTax = value * 0.15;
        }
      }
      if (typeTax == 2) {
        if (interesttaxtype == 1) {
          netTax = value * 0.1;
        } else if (interesttaxtype == 2) {
          netTax = value * 0.5;
        } else {
          netTax = value * 0.4;
        }
      }

      if (typeTax == 3) {
        if (interesttaxtype == 1) {
          netTax = value * 0.01;
        } else {
          netTax = value * 0.1;
        }
      }
    }
    update();
  }

  @override
  void onInit() {
    frompage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }

  void resetAll() {
    Get.until((route) => Get.currentRoute == frompage);
  }

  void BackFromInteresttaxtype() {
    interesttaxtype = 0;
  }

  void BackValuotax() {
    fixedValueController.clear();
    fixedValueControllerError = null;
    netTax = 0;
  }
}
