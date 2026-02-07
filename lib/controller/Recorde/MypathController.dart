import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/datasource/Remote/MyPathData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/CommonquestionsData.dart';
import '../../data/datasource/Remote/NatureoftheactivityData.dart';
import '../../data/model/ActivitysModel.dart';
import '../../data/model/NatureoftheactivityModel.dart';
import '../../view/screen/MyPath/ActivityType.dart';
import '../../view/screen/MyPath/MoralActivities.dart';
import '../../view/screen/MyPath/NatureOfActivity.dart';
import '../../view/screen/MyPath/TaxSystemsTypeInMypath.dart';

class Mypathcontroller extends GetxController {
  //
  void selectedPerson(int i) {}
  void gotoNatureofactivity() {}
  //
  void selectNatureofactivity(int i) {}
  void backtoPersonType() {}
  void gotoActivitytype() {}
  //
  void backtonatureofactivity() {}
  void selectativitytype(int i, int statustaxs, int taxids) {}
  void gotoTaxsystemstype() {}
  //
  void backtoativitytype() {}
  void selectTaxsystemstype(int i) {}
  // void gotoTaxsystemstype() {}
  //
  void selectMoralactivities(int i) {}
  void backtoPersonType2() {}
}

class MypathcontrollerImp extends Mypathcontroller {
  Mypathdata mypathdata = Mypathdata(Get.find());
  Activitydata activitydata = Activitydata(Get.find());
  Natureoftheactivitydata natureoftheactivitydata = Natureoftheactivitydata(
    Get.find(),
  );
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  List<Natureoftheactivitymodel> natureoftheactivity = [];
  List<ActivityModel> data = [];
  List<ActivityModel> filteredData = [];

  // personType
  int personType = -1;
  // 1 شخص طبيعي
  // 2 شخص معنوي

  @override
  selectedPerson(int i) {
    personType = i;
    update();
  }

  @override
  gotoNatureofactivity() {
    if (personType == -1) {
      showSnackbar("خطأ".tr, "يرجى اختيار طبيعة الشخص".tr, Colors.red);
      return;
    }
    if (personType == 1) {
      viewnatureoftheactivity();
      Get.to(Natureofactivity());
    } else {
      Get.to(Moralactivities());
    }
  }

  //Natureofactivity
  int natureofactivity = -1;
  @override
  selectNatureofactivity(int i) {
    natureofactivity = i;
    update();
  }

  @override
  backtoPersonType() {
    natureofactivity = -1;
    Get.back();
  }

  @override
  gotoActivitytype() {
    if (natureofactivity == -1) {
      showSnackbar("خطأ".tr, "يرجى اختيار طبيعة النشاط".tr, Colors.red);
      return;
    }
    viewdataactivity();
    Get.to(Activitytype());
  }

  //Activitytype
  int ativitytype = -1;
  int statustax = -1;
  int taxid = -1;

  @override
  selectativitytype(int i, int statustaxs, int taxids) {
    ativitytype = i;
    statustax = statustaxs;
    taxid = taxids;
    update();
  }

  @override
  backtonatureofactivity() {
    ativitytype = -1;
    statustax = -1;
    taxid = -1;
    Get.back();
  }

  @override
  gotoTaxsystemstype() {
    if (ativitytype == -1) {
      showSnackbar("خطأ".tr, "يرجى اختيار  النشاط".tr, Colors.red);
      return;
    }
    statustax == 1 ? Get.to(Taxsystemstypeinmypath()) : adddata();
  }

  //taxsystemstype
  @override
  selectTaxsystemstype(int i) {
    taxid = i;
    update();
  }

  @override
  backtoativitytype() {
    taxid = -1;
    Get.back();
  }

  //Moralactivities
  int moralactivities = -1;
  //1 شركة مدنية
  //2 شركة اخرى

  @override
  selectMoralactivities(int i) {
    moralactivities = i;
    i == 1 ? taxid = 0 : taxid = 2;
    update();
  }

  @override
  backtoPersonType2() {
    moralactivities = -1;
    taxid = -1;
    Get.back();
  }

  Future<void> viewnatureoftheactivity() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await natureoftheactivitydata.viewdata();
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        natureoftheactivity.clear();
        List listdata = response['data'];
        natureoftheactivity.addAll(
          listdata.map((e) => Natureoftheactivitymodel.fromJson(e)),
        );
        natureoftheactivity = List.from(natureoftheactivity);
        if (natureoftheactivity.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  Future<void> viewdataactivity() async {
    statusrequest = Statusrequest.loadeng;
    update();

    final actData = {"nataire_activitys_id": natureofactivity};

    var response = await activitydata.viewdata(actData);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => ActivityModel.fromJson(e)));
        filteredData = List.from(data);
        if (filteredData.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredData = List.from(data);
    } else {
      filteredData = data
          .where(
            (element) =>
                element.localizedName.toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                (element.localizedBody.toLowerCase().contains(
                  query.toLowerCase(),
                )),
          )
          .toList();
    }
    update();
  }

  Future<void> adddata() async {
    if (taxid == -1) {
      showSnackbar("خطأ".tr, "يرجى اختيار النظام الضريبي".tr, Colors.red);
      return;
    }

    statusrequest = Statusrequest.loadeng;
    update();
    Map<String, dynamic> requestData = {
      "person_type": personType,
      if (natureofactivity != -1) "nataire_activity_id": natureofactivity,
      if (ativitytype != -1) "activity_id": ativitytype,
      "tax_id": taxid,
      if (moralactivities != -1) "activit_special": moralactivities,
    };

    print("=================$requestData");

    var response = await mypathdata.adddata(requestData);
    print("Add Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success && response["status"] == 1) {
      Get.offAllNamed(Approutes.navigationBar);
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }
}
