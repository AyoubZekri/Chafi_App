import 'package:get/get.dart';

import 'package:flutter/material.dart';
import '../../core/constant/Colorapp.dart';
import '../HomeController.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Categorydata.dart';
import '../../data/model/CategoryModel.dart';

class Categoriesappcontroller extends GetxController {
  int? nameappar;
  int? taxid;

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Categorydata categorydata = Categorydata(Get.find());

  List<CategoryModel> data = [];

  // عرض البيانات
  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    final actData = {"type_cat": 2, "tax_id": taxid};

    var response = await categorydata.viewdata(actData);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => CategoryModel.fromJson(e)));
        data = List.from(data);
        if (data.isEmpty) {
          statusrequest = Statusrequest.nodata;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  bool get isLoggedIn =>
      myServices.sharedPreferences?.getString("token") != null;
  gotoInfo(int id) {
    if (!isLoggedIn) {
      Get.defaultDialog(
        title: "تنبيه".tr,
        middleText: "يجب عليك تسجيل الدخول أولاً".tr,
        titleStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColor.typography,
        ),
        middleTextStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF566573),
        ),
        radius: 15,
        textCancel: "إلغاء".tr,
        cancelTextColor: AppColor.typography,
        textConfirm: "تسجيل الدخول".tr,
        confirmTextColor: AppColor.white,
        buttonColor: AppColor.typography,
        onConfirm: () {
          Get.back();
          try {
            Get.find<HomecontrollerImp>().onClose();
          } catch (e) {}
          Get.toNamed(Approutes.googleSignIn, arguments: {"type": 1});
        },
      );
      return;
    }
    Get.toNamed(
      Approutes.institutionsinfo,
      arguments: {"name": nameappar, "type": 9, "cat_id": id},
    );
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    nameappar = args["name"];
    taxid = args["tax_id"];
    viewdata();
    super.onInit();
  }

  Future<void> getData() async {
    viewdata();
  }
}
