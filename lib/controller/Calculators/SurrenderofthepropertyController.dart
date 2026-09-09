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
  String? depositdateErorr;
  String? paymentdateErorr;

  TextEditingController sellingprice = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController sellingexpenses = TextEditingController();
  TextEditingController purchaseexpenses = TextEditingController();
  TextEditingController saledate = TextEditingController();
  TextEditingController purchasedate = TextEditingController();
  TextEditingController depositdate = TextEditingController();
  TextEditingController paymentdate = TextEditingController();

  double depositPenalty = 0;
  double paymentPenalty = 0;

  double netTax = 0;
  double baseTax15 = 0;
  double total = 0;

  double sellingprices = 0;
  double purchaseprices = 0;
  double sellingexpensess = 0;
  double purchaseexpensess = 0;
  double annualDiscountAmount = 0;
  double residenceDiscountAmount = 0;

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

  double calculateDepositPenalty(
    DateTime baseDate,
    DateTime depositDate,
    double amount,
  ) {
    DateTime delayStart = baseDate.add(const Duration(days: 30));
    if (!depositDate.isAfter(delayStart)) {
      return 0;
    }

    int daysLate = depositDate.difference(delayStart).inDays;
    int monthsLate = (daysLate - 1) ~/ 30;

    if (amount == 0) {
      if (monthsLate == 0) {
        return 250000;
      } else if (monthsLate == 1) {
        return 500000;
      } else {
        return 1000000;
      }
    } else {
      if (monthsLate == 0) {
        return amount * 0.10;
      } else if (monthsLate == 1) {
        return amount * 0.13;
      } else if (monthsLate == 2) {
        return amount * 0.16;
      } else if (monthsLate == 3) {
        return amount * 0.19;
      } else if (monthsLate == 4) {
        return amount * 0.22;
      } else {
        return amount * 0.25;
      }
    }
  }

  double calculatePaymentPenalty(
    DateTime baseDate,
    DateTime paymentDate,
    double amount,
    double depositPenaltyValue,
  ) {
    
    DateTime delayStart = baseDate.add(const Duration(days: 30));

    if (!paymentDate.isAfter(delayStart)) {
      return 0;
    }

    int daysLate = paymentDate.difference(delayStart).inDays;
    int monthsLate = (daysLate - 1) ~/ 30;

    double percent = (monthsLate == 0) ? 0.05 : 0.10;

    if (amount == 0) {
      return depositPenaltyValue * percent;
    }

    return amount * percent;
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

    if (sellingprices == 0 && sellingexpensess > 0) {
      showSnackbar(
        "خطأ".tr,
        "سعر الإقتناء غير معروف وبتالي ترفض مصاريفه".tr,
        Colors.red,
      );
      return;
    }

    sellingprices = sellingprices == 0 ? (purchaseprices * 0.4) : sellingprices;

    final datasale = parseDate(saledate.text);
    final datapurchase = parseDate(purchasedate.text);
    final datadeposit = parseDate(depositdate.text);
    final datapayment = parseDate(paymentdate.text);
    print("==============$datasale");
    print("==============datapurchase $datapurchase");
    if (!hasError) {
      if (datasale != null &&
          datapurchase != null &&
          datadeposit != null &&
          datapayment != null) {
        int years = (datasale.year - datapurchase.year) + 1;
        print("===================$years");
        // 1. حساب فائض القيمة (سعر البيع - سعر الشراء - مصاريف الاقتناء - مصاريف البيع)
        // مصاريف الاقتناء في حدود 30% من سعر الشراء
        double cappedPurchaseExpenses = sellingexpensess > sellingprices * 0.3
            ? sellingprices * 0.3
            : sellingexpensess;
        print(
          "cappedPurchaseExpenses ================  $cappedPurchaseExpenses",
        );
        print("sellingprices ================  $sellingprices");
        print("purchaseexpenses ================  $purchaseexpensess");
        print("purchaseprices ================  $purchaseprices");
        netTax =
            purchaseprices -
            sellingprices -
            cappedPurchaseExpenses -
            purchaseexpensess;

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
        residenceDiscountAmount = singleResidence == 1 ? discountyear * 0.5 : 0;
        discount = discountyear - residenceDiscountAmount;

        if (discount < 0) {
          discount = 0;
        }

        // 4. حساب الضريبة النهائية (15%)
        baseTax15 = discount * 0.15;
        if (baseTax15 < 0) {
          baseTax15 = 0;
        }

        depositPenalty = calculateDepositPenalty(datasale, datadeposit, baseTax15);
        paymentPenalty = calculatePaymentPenalty(
          datasale,
          datapayment,
          baseTax15,
          depositPenalty,
        );

        double totalPenalties = depositPenalty + paymentPenalty;
        total = baseTax15 + totalPenalties;
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

    if (depositdate.text.isEmpty) {
      depositdateErorr = "تاريخ الإيداع مطلوب".tr;
      hasError = true;
    } else {
      depositdateErorr = validInput(depositdate.text, 20, 3, "Text");
      if (depositdateErorr != null) hasError = true;
    }

    if (paymentdate.text.isEmpty) {
      paymentdateErorr = "تاريخ الدفع مطلوب".tr;
      hasError = true;
    } else {
      paymentdateErorr = validInput(paymentdate.text, 20, 3, "Text");
      if (paymentdateErorr != null) hasError = true;
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
      empty: true,
    );
    sellingexpensesErorr = validInput(
      sellingexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
      empty: true,
    );
    purchaseexpensesErorr = validInput(
      purchaseexpenses.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
      empty: true,
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
    depositdateErorr = null;
    paymentdateErorr = null;

    sellingprice.clear();
    purchaseprice.clear();
    sellingexpenses.clear();
    purchaseexpenses.clear();
    saledate.clear();
    purchasedate.clear();
    depositdate.clear();
    paymentdate.clear();
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
