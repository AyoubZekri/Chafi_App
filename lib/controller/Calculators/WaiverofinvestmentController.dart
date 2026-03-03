import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/different/WaiverOfInvestment/Shwovalue.dart';

class Waiverofinvestmentcontroller extends GetxController {
  String? fromPage;

  String? sellingpriceErorr;
  String? purchasepriceErorr;
  String? yearsofvalidityErorr;
  String? purchasedateErorr;
  String? saledateErorr;

  TextEditingController sellingprice = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController yearsofvalidity = TextEditingController();
  TextEditingController saledate = TextEditingController();
  TextEditingController purchasedate = TextEditingController();
  double total = 0;

  double sellingprices = 0;
  double purchaseprices = 0;
  int yearsofvaliditys = 0;
  double remainingacquisition = 0;
  double remaininSale = 0;

  void calcul() {
    bool hasError = validateAllFields();
    sellingprices =
        double.tryParse(sellingprice.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    purchaseprices =
        double.tryParse(purchaseprice.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    yearsofvaliditys =
        int.tryParse(yearsofvalidity.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    if (yearsofvaliditys <= 0) {
      showSnackbar("خطأ".tr, "مدة الصلاحية غير صحيحة".tr, Colors.red);
      return;
    }
    final datasale = parseDate(saledate.text);
    final datapurchase = parseDate(purchasedate.text);
    print("==============$datasale");

    if (!hasError) {
      if (datasale != null && datapurchase != null) {
        int years = datasale.year - datapurchase.year;

        // if (datasale.month < datapurchase.month ||
        //     (datasale.month == datapurchase.month &&
        //         datasale.day < datapurchase.day)) {
        //   years--;
        // }

        if (years < 0) years = 0;
        if (years > yearsofvaliditys) years = yearsofvaliditys;

        double divide = purchaseprices / yearsofvaliditys;
        double remaining = years * divide;

        remainingacquisition = purchaseprices - remaining;
        remaininSale = sellingprices - remainingacquisition;

        if (remaininSale <= 0) {
          total = 0;
        } else {
          total = years > 3 ? remaininSale * 0.35 : remaininSale * 0.70;
        }
      }
      Get.to(() => Shwovalue());
    }

    update();
  }

  void resetAll() {
    Get.until((route) => Get.currentRoute == fromPage);
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }

  bool validateAllFields() {
    bool hasError = false;

    // ======= التواريخ =======
    if (purchasedate.text.isEmpty) {
      purchasedateErorr = "تاريخ الإقتناء مطلوب".tr;
      hasError = true;
    } else {
      purchasedateErorr = validInput(purchasedate.text, 20, 3, "Text");
      if (purchasedateErorr != null) hasError = true;
    }

    if (saledate.text.isEmpty) {
      saledateErorr = "تاريخ التنازل مطلوب".tr;
      hasError = true;
    } else {
      saledateErorr = validInput(saledate.text, 20, 3, "Text");
      if (saledateErorr != null) hasError = true;
    }

    sellingpriceErorr = validInput(
      sellingprice.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    purchasepriceErorr = validInput(
      purchaseprice.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    yearsofvalidityErorr = validInput(
      yearsofvalidity.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    if (sellingpriceErorr != null) hasError = true;
    if (purchasepriceErorr != null) hasError = true;
    if (yearsofvalidityErorr != null) hasError = true;

    update();
    return hasError;
  }

  void BackFromWaiverofinvestmentvalue() {
    sellingpriceErorr = null;
    purchasepriceErorr = null;
    yearsofvalidityErorr = null;
    purchasedateErorr = null;
    saledateErorr = null;

    sellingprice.clear();
    purchaseprice.clear();
    yearsofvalidity.clear();
    saledate.clear();
    purchasedate.clear();
  }

  void backFromShwovalue() {}
}
