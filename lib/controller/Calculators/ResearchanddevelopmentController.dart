import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';
import 'package:chafi/core/functions/valiedinput.dart';

class Researchanddevelopmentcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? accountingprofitErorr;
  TextEditingController accountingprofit = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

  calcul() {
    accountingprofitErorr = validInput(
      accountingprofit.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    tasStamp =
        double.tryParse(
          accountingprofit.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (accountingprofitErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      netTax = tasStamp * 0.3;
    }
    update();
  }

  void Back() {
    accountingprofit.clear();
    accountingprofitErorr = null;
    netTax = 0;
    update();
    Get.back();
  }

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
    addenter(4);
    super.onInit();
  }
}
