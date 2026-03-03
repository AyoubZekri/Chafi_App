import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/different/SurrenderOfTheProperty/Shwovalue.dart';
import '../../view/screen/Calculators/different/SurrenderOfTheProperty/SurrenderOfThePropertyValue.dart';

class Surrenderofthepropertycontroller extends GetxController {
  String? fromPage;
  int singleResidence = 0; //YES 1 NO 2

  String? sellingpriceErorr;
  String? purchasepriceErorr;
  String? sellingexpensesErorr;
  String? purchaseexpensesErorr;
  String? purchasedateErorr;
  String? saledateErorr;

  TextEditingController sellingprice = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController sellingexpenses = TextEditingController();
  TextEditingController purchaseexpenses = TextEditingController();
  TextEditingController saledate = TextEditingController();
  TextEditingController purchasedate = TextEditingController();
  double netTax = 0;
  double total = 0;

  double sellingprices = 0;
  double purchaseprices = 0;
  double sellingexpensess = 0;
  double purchaseexpensess = 0;
  int numyear = 0;

  double discount = 0;
  double discountyear = 0;

  void selectedOvercome(int i) {
    singleResidence = i;
    update();
  }

  void gotoPropertytype() {
    if (singleResidence == 0) {
      return showSnackbar("خطأ".tr, "يرجى إختيار نوع السكن".tr, Colors.red);
    }
    Get.to(Surrenderofthepropertyvalue());
  }

  void calcul() {
    bool hasError = validateAllFields();
    sellingprices =
        double.tryParse(sellingprice.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    purchaseprices =
        double.tryParse(purchaseprice.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    sellingexpensess =
        double.tryParse(
          sellingexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    purchaseexpensess =
        double.tryParse(
          purchaseexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
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

        if (years > 3) {
          numyear = years;
          numyear = numyear - 3;
        }
        netTax =
            (purchaseprices -
            sellingprices -
            sellingexpensess -
            purchaseexpensess);
        if (netTax < 0) {
          netTax = 0;
        }
        discountyear = (numyear * 0.05) > 0.5
            ? (0.5 * netTax)
            : ((numyear * 0.05) * netTax);
        discountyear = netTax - discountyear;
        if (discountyear < 0) {
          discountyear = 0;
        }
        discount = singleResidence == 1 ? discountyear * 0.5 : 0;
        discount = discountyear - discount;
        if (discount < 0) {
          discount = 0;
        }
        total = discount * 0.15 < 0 ? 0 : discount * 0.15;
        if (total < 0) {
          total = 0;
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
    sellingexpensesErorr = validInput(
      sellingexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    purchaseexpensesErorr = validInput(
      purchaseexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    if (sellingpriceErorr != null) hasError = true;
    if (purchasepriceErorr != null) hasError = true;
    if (sellingexpensesErorr != null) hasError = true;
    if (purchaseexpensesErorr != null) hasError = true;

    update();
    return hasError;
  }

  void BackFromSurrenderofthepropertytype() {
    singleResidence = 0;
  }

  void BackFromSurrenderofthepropertyvalue() {
    sellingpriceErorr = null;
    purchasepriceErorr = null;
    sellingexpensesErorr = null;
    purchaseexpensesErorr = null;
    purchasedateErorr = null;
    saledateErorr = null;

    sellingprice.clear();
    purchaseprice.clear();
    sellingexpenses.clear();
    purchaseexpenses.clear();
    saledate.clear();
    purchasedate.clear();
  }

  void backFromShwovalue() {}
}
