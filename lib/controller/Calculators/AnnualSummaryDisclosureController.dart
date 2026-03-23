import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/Realsystem/AnnualSummaryDisclosure/AnnualSummaryDisclosure.dart';

class Annualsummarydisclosurecontroller extends GetxController {
  String? fromPage;
  String? annualSummaryDisclosureErorr;
  int lossORprofit = 0;
  TextEditingController annualSummaryDisclosure = TextEditingController();
  double netTax = 0;
  double annualSummary = 0;

  selectedPerson(int i) {
    lossORprofit = i;
    update();
  }

  void gotodatacreate() {
    if (lossORprofit == 0) {
      return showSnackbar(
        "خطأ".tr,
        "يرجى تحديد نتيجة السنة المالية أولا".tr,
        Colors.red,
      );
    }
    Get.to(Annualsummarydisclosure());
  }

  void calcul() {
    annualSummaryDisclosureErorr = validInput(
      annualSummaryDisclosure.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );

    if (annualSummaryDisclosureErorr != null) {
      netTax = 0; // هنا توقف الحساب
      annualSummary = 0;
    } else {
      // فقط إذا ماكانش خطأ
      annualSummary =
          double.tryParse(
            annualSummaryDisclosure.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      netTax = (annualSummary * 0.25) > 100000000
          ? 100000000
          : (annualSummary * 0.25);
    }

    update();
  }

  void backFromAnnualsummarydisclosure() {
    annualSummaryDisclosure.clear();
    netTax = 0;
    Get.back();
    update();
  }

  void backFromLossorprofit() {
    lossORprofit = 0;
    Get.back();
    update();
  }

  void resetAll() {
    lossORprofit = 0;
    annualSummaryDisclosure.clear();
    netTax = 0;
    Get.until((route) => Get.currentRoute == fromPage);
    update();
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
