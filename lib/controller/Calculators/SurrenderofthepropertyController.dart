import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';
import 'package:chafi/core/functions/Snacpar.dart';
import 'package:chafi/core/functions/trundatefromStringtodate.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:chafi/view/screen/Calculators/different/SurrenderOfTheProperty/Shwovalue.dart';
import 'package:chafi/view/screen/Calculators/different/SurrenderOfTheProperty/SurrenderOfThePropertyValue.dart';

class Surrenderofthepropertycontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
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
  double annualDiscountAmount=0;
  double residenceDiscountAmount=0;

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
    print("sellingprices ================  $sellingprices");
    purchaseprices =
        double.tryParse(purchaseprice.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    print("purchaseprices ================  $purchaseprices");

    sellingprices = sellingprices == 0 ? (purchaseprices * 0.4) : sellingprices;
    sellingexpensess =
        double.tryParse(
          sellingexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    print("sellingexpensess ================  $sellingexpensess");
    purchaseexpensess =
        double.tryParse(
          purchaseexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    print("purchaseexpensess ================  $purchaseexpensess");
    final datasale = parseDate(saledate.text);
    final datapurchase = parseDate(purchasedate.text);
    print("==============$datasale");

    if (!hasError) {
      if (datasale != null && datapurchase != null) {
        int years = datasale.year - datapurchase.year;

        // 1. حساب فائض القيمة (سعر البيع - سعر الشراء - مصاريف الاقتناء - مصاريف البيع)
        // مصاريف الاقتناء في حدود 30% من سعر الشراء
        double cappedPurchaseExpenses = sellingprices > sellingexpensess * 0.3
            ? sellingexpensess * 0.3
            : sellingprices;

        netTax =
            purchaseprices -
            sellingprices -
            cappedPurchaseExpenses -
            sellingexpensess;
        print("netTax ================  $netTax");
        if (netTax < 0) {
          netTax = 0;
        }

        // 2. التخفيض السنوي: يبدأ من السنة الثالثة بـ 5% كل سنة (الحد الأقصى 50%)
        double annualDiscountRate = 0.0;
        if (years >= 3) {
          int applicableYears = years - 2; // السنة 3 = 5%، السنة 4 = 10%
          annualDiscountRate = applicableYears * 0.05;
          if (annualDiscountRate > 0.5) {
            annualDiscountRate = 0.5;
          }
        }

        // discountyear سيمثل المبلغ المتبقي بعد التخفيض السنوي
        annualDiscountAmount = netTax * annualDiscountRate;
        discountyear = netTax - annualDiscountAmount;

        // 3. التخفيض السكني الوحيد: يطبق على المبلغ المتبقي بعد التخفيض السنوي
        residenceDiscountAmount = singleResidence == 1
            ? discountyear * 0.5
            : 0;
        discount = discountyear - residenceDiscountAmount;

        if (discount < 0) {
          discount = 0;
        }

        // 4. حساب الضريبة النهائية (15%)
        total = discount * 0.15;
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
      empty: true,
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

  Future<void> addenter(int type_stats) async {
    update();
    if (!await checkInternet()) {
      print("=======checkInternet false=====${await checkInternet()}");
      return;
    }
    var response = await postdata.adddata({
      'device_id': myServices.sharedPreferences?.getString('device_id'),
      "type_stats": type_stats,
    });
    print("=======================$response");
    statusrequest = handlingData(response);
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        print('==================enter+1');
        statusrequest = Statusrequest.success;
      }
    }
    update();
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
