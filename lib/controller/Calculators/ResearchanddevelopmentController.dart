import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';

class Researchanddevelopmentcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? accountingprofitErorr;
  TextEditingController accountingprofit = TextEditingController();
  double netTax = 0;
  double tasStamp = 0;
  int type = 1;

  void selectedType(int val) {
    type = val;
    update();
  }

  void gotocalculator(BuildContext context) {
    if (type == 3) {
      // Show modern dialog for "Other Institutions"
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColor.typography,
                  size: 50,
                ),
                const SizedBox(height: 15),
                Text(
                  "تنبيه".tr,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "هذه المؤسسة غير معنية بالتخفيض".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.typography,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () => Get.back(),
                    child: Text(
                      "حسناً".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      Get.toNamed('/ResearchanddevelopmentCalc');
    }
  }

  calcul() {
    accountingprofitErorr = validInput(
      accountingprofit.text.replaceAll(RegExp(r'[^0-9]'), ''),
      200,
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
    netTax = netTax > 20000000000 ? 20000000000 : netTax;
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
