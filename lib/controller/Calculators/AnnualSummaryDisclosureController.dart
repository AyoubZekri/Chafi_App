import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/routes.dart';
import '../../view/screen/Calculators/Realsystem/AnnualSummaryDisclosure/AnnualSummaryDisclosure.dart';

class Annualsummarydisclosurecontroller extends GetxController {
  int lossORprofit = 0;
  TextEditingController annualSummaryDisclosure = TextEditingController();
  double netTax = 0;
  double annualSummary = 0;

  selectedPerson(int i) {
    lossORprofit = i;
    update();
  }

  void gotodatacreate() {
    Get.to(Annualsummarydisclosure());
  }

  calcul() {
    annualSummary = double.tryParse(annualSummaryDisclosure.text) ?? 0;
    netTax = (annualSummary * 0.25) > 1000000
        ? 1000000
        : (annualSummary * 0.25);

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
    Get.until((route) => Get.currentRoute == Approutes.calculatorsrealsystem);
    update();
  }
}
