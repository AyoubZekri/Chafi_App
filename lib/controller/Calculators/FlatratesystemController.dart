import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/ArbitrarySystem.dart/FlatRate/Shwoflatratesystem.dart';

class FlatratesystemController extends GetxController {
  String? fromPage;

  TextEditingController goodsValue = TextEditingController();
  String? goodsValueErorr;

  double singleTax = 0;
  double amountPaidToCustoms = 0;
  double profitMargin = 0;
  double customsDuties = 0;

  void calcul() {
    bool hasError = validateAllFields();
    if (!hasError) {
      double value =
          double.tryParse(goodsValue.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
          0;

      // هامش الربح وهو 30% من قيمة السلعة
      profitMargin = value * 0.30;
      // الحقوق الجمركية وهي 5% من قيمة السلعة
      customsDuties = value * 0.05;

      // الضريبة الجزافية الوحيدة
      singleTax = (value + profitMargin + customsDuties) * 0.005; // 0.05 is 5%

      // المبلغ المدفوع لمصلحة الجمارك
      amountPaidToCustoms = customsDuties + singleTax;

      Get.to(() => const Shwoflatratesystem());
    }
  }

  bool validateAllFields() {
    bool hasError = false;

    goodsValueErorr = validInput(
      goodsValue.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );

    if (goodsValueErorr != null) hasError = true;

    update();
    return hasError;
  }

  void BackFromFlatRateValue() {
    goodsValueErorr = null;
    goodsValue.clear();
  }

  void backFromShwovalue() {}

  void resetAll() {
    Get.until((route) => Get.currentRoute == fromPage);
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
