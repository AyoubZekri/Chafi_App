import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/bonusesandcompensations.dart';
import '../../data/model/BonusModel.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/bonuses_and_compensations.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/personscondition.dart';

class bonusesandcompensationcontroller extends GetxController {
  int typeAccount = 0;
  int personscondition = 0;

  Bonusesandcompensation bonusesandcompensation = Bonusesandcompensation(
    Get.find(),
  );
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Map<int, TextEditingController> valueControllers = {};
  RxSet<int> selectedgroup = <int>{}.obs;

  List<BonusModel> data = [];
  Map<int, List<BonusModel>> groupedData = {};

  void selectedtypeAccount(int i) {
    typeAccount = i;
    update();
  }

  void gotoPersonscondition() {
    print("===============$typeAccount");
    if (typeAccount == 0) {
      return showSnackbar("خطأ".tr, "الرجاء إختيار نوع الحساب".tr, Colors.red);
    }
    Get.to(() => Personscondition());
  }

  void selectedpersonscondition(int i) {
    personscondition = i;
    update();
  }

  void gotobonusesandcompensations() {
    print("===============$personscondition");
    if (personscondition == 0) {
      return showSnackbar(
        "خطأ".tr,
        "الرجاء اختيار نوع الشخص إذا كنت تنتمي إلى هؤلاء الأشخاص، أو اختر 'لست منهم'."
            .tr,
        Colors.red,
      );
    }
    Get.to(() => BonusesAndCompensations());
  }

  void togglegroup(int id, bool value) {
    print(id);
    print(value);
    if (value) {
      selectedgroup.add(id);
      if (!valueControllers.containsKey(id)) {
        valueControllers[id] = TextEditingController();
      }
    } else {
      selectedgroup.remove(id);
      valueControllers[id]?.dispose();
      valueControllers.remove(id);
    }
    update();
  }

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await bonusesandcompensation.viewdata();
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => BonusModel.fromJson(e)));

        for (var bonus in data) {
          if (!groupedData.containsKey(bonus.category)) {
            groupedData[bonus.category] = [];
          }
          groupedData[bonus.category]!.add(bonus);
        }
        if (data.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    viewdata();
    super.onInit();
  }

  void BackFromAccounttype() {}

  void BackFromPersonscondition() {
    personscondition = 0;
  }

  void BackFromBonusesAndCompensations() {}
}
