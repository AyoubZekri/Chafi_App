import 'package:chafi/core/class/Statusrequest.dart' show Statusrequest;
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/valiedinput.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';

class Advertisingandsponsorshipcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());

  String? BusinessnumberErorr;
  TextEditingController Businessnumber = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;
  Statusrequest statusrequest = Statusrequest.none;
  Myservices myServices = Get.find();

  calcul() {
    BusinessnumberErorr = validInput(
      Businessnumber.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    tasStamp =
        double.tryParse(
          Businessnumber.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (BusinessnumberErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      netTax = tasStamp * 0.10;
    }

    netTax = netTax > 3000000000 ? 3000000000 : netTax;
    update();
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

  void Back() {
    Businessnumber.clear();
    BusinessnumberErorr = null;
    netTax = 0;
    update();
    Get.back();
  }

  @override
  void onInit() {
    addenter(4);
    super.onInit();
  }
}
