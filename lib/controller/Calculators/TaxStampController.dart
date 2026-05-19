import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/valiedinput.dart';
import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';

class Taxstampcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? tasStampsErorr;
  TextEditingController tasStamps = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;

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

  calcul() {
    tasStampsErorr = validInput(
      tasStamps.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    tasStamp =
        double.tryParse(tasStamps.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    if (tasStampsErorr != null) {
      netTax = 0; // هنا توقف الحساب
      tasStamp = 0;
    } else {
      if (tasStamp <= 3000000) {
        netTax = tasStamp * 0.01;
      } else if (tasStamp > 3000000 && tasStamp <= 10000000) {
        netTax = tasStamp * 0.015;
      } else if (tasStamp > 10000000) {
        netTax = tasStamp * 0.02;
      }

      if (netTax <= 500) {
        netTax = 500;
      }
    }
    update();
  }

  void Back() {
    tasStamps.clear();
    tasStampsErorr = null;
    netTax = 0;
    update();
    Get.back();
  }
}
