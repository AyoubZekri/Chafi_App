import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/different/WaiverOfInvestment/Shwovalue.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';

class Waiverofinvestmentcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
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
  double discount = 0;
  int discountPercentage = 0;
  int totalPercentage = 0;

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
    print("========datasale$datasale");
    print("========datapurchase$datapurchase");

    print("==============$datasale");

    if (!hasError) {
      if (datasale != null && datapurchase != null) {
        int totalMonths =
            (datasale.year - datapurchase.year) * 12 +
            (datasale.month - datapurchase.month) +
            1;

        if (datapurchase.day > 15) {
          totalMonths -= 1;
        }
        if (datasale.day <= 15) {
          totalMonths -= 1;
        }

        if (totalMonths < 0) totalMonths = 0;

        double years = totalMonths / 12.0;
        print("=================$years");
        if (years > yearsofvaliditys) years = yearsofvaliditys.toDouble();

        double divide = purchaseprices / yearsofvaliditys;
        double remaining = years * divide;

        remainingacquisition = purchaseprices - remaining;
        remaininSale = sellingprices - remainingacquisition;
        print("==============$years");

        if (remaininSale <= 0) {
          discount = 0;
          discountPercentage = 0;
          totalPercentage = 100;
        } else {
          if (years > 3) {
            discount = remaininSale * 0.65;
            discountPercentage = 65;
            totalPercentage = 35;
          } else {
            discount = remaininSale * 0.30;
            discountPercentage = 30;
            totalPercentage = 70;
          }
        }
        total = remaininSale - discount;
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
    addenter(4);
    super.onInit();
  }
}
