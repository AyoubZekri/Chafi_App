import 'dart:io';

import 'package:chafi/controller/HomeController.dart';
import 'package:chafi/controller/ProfaileController.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../LinkApi.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/SaveImage.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Logingoogle.dart';

class Infousercontroller extends GetxController {
  gotoNavigationBar() {}
}

class InfousercontrollerImp extends Infousercontroller {
  TextEditingController username = TextEditingController();
  // TextEditingController wilaya = TextEditingController();
  TextEditingController numperPhone = TextEditingController();
  Statusrequest statusrequest = Statusrequest.none;
  int? selectedstate;
  int type = 0;

  final List<Map<String, Object>> state = [
    {"state": "أدرار", "number": 1},
    {"state": "الشلف", "number": 2},
    {"state": "الأغواط", "number": 3},
    {"state": "أم البواقي", "number": 4},
    {"state": "باتنة", "number": 5},
    {"state": "بجاية", "number": 6},
    {"state": "بسكرة", "number": 7},
    {"state": "بشار", "number": 8},
    {"state": "البليدة", "number": 9},
    {"state": "البويرة", "number": 10},
    {"state": "تمنراست", "number": 11},
    {"state": "تبسة", "number": 12},
    {"state": "تلمسان", "number": 13},
    {"state": "تيارت", "number": 14},
    {"state": "تيزي وزو", "number": 15},
    {"state": "الجزائر", "number": 16},
    {"state": "الجلفة", "number": 17},
    {"state": "جيجل", "number": 18},
    {"state": "سطيف", "number": 19},
    {"state": "سعيدة", "number": 20},
    {"state": "سكيكدة", "number": 21},
    {"state": "سيدي بلعباس", "number": 22},
    {"state": "عنابة", "number": 23},
    {"state": "قالمة", "number": 24},
    {"state": "قسنطينة", "number": 25},
    {"state": "المدية", "number": 26},
    {"state": "مستغانم", "number": 27},
    {"state": "المسيلة", "number": 28},
    {"state": "معسكر", "number": 29},
    {"state": "ورقلة", "number": 30},
    {"state": "وهران", "number": 31},
    {"state": "البيض", "number": 32},
    {"state": "إليزي", "number": 33},
    {"state": "برج بوعريريج", "number": 34},
    {"state": "بومرداس", "number": 35},
    {"state": "الطارف", "number": 36},
    {"state": "تندوف", "number": 37},
    {"state": "تيسمسيلت", "number": 38},
    {"state": "الوادي", "number": 39},
    {"state": "خنشلة", "number": 40},
    {"state": "سوق أهراس", "number": 41},
    {"state": "تيبازة", "number": 42},
    {"state": "ميلة", "number": 43},
    {"state": "عين الدفلة", "number": 44},
    {"state": "النعامة", "number": 45},
    {"state": "عين تموشنت", "number": 46},
    {"state": "غرداية", "number": 47},
    {"state": "غليزان", "number": 48},
    {"state": "تيميمون", "number": 49},
    {"state": "برج باجي مختار", "number": 50},
    {"state": "أولاد جلال", "number": 51},
    {"state": "بني عباس", "number": 52},
    {"state": "عين صالح", "number": 53},
    {"state": "عين قزام", "number": 54},
    {"state": "تقرت", "number": 55},
    {"state": "جانت", "number": 56},
    {"state": "المغير", "number": 57},
    {"state": "المنيعة", "number": 58},
    {"state": "آفلو", "number": 59},
    {"state": "الأبيض سيدي الشيخ", "number": 60},
    {"state": "العريشة", "number": 61},
    {"state": "القنطرة", "number": 62},
    {"state": "بريكة", "number": 63},
    {"state": "بوسعادة", "number": 64},
    {"state": "بير العاتر", "number": 65},
    {"state": "قصر البخاري", "number": 66},
    {"state": "قصر الشلالة", "number": 67},
    {"state": "عين وسارة", "number": 68},
    {"state": "مسعد", "number": 69},
  ];

  LoginData loginData = LoginData(Get.find());
  Myservices myServices = Get.find();
  String? uid;
  bool isSwitched = false;
  @override
  void gotoNavigationBar() async {
    if (selectedstate == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار الولاية".tr, Colors.red);
      return;
    }

    if (isSwitched == false) {
      showSnackbar("خطأ".tr, "يجب الموافقة على الشروط والأحكام".tr, Colors.red);
      return;
    }
    statusrequest = Statusrequest.loadeng;
    update();
    final selectedStateData = state.firstWhere(
      (element) => element['number'] == selectedstate,
    );
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("======$uid");
    print("======$fcmToken");

    var response = await loginData.loginGoogle({
      "uid": uid,
      "token": fcmToken,
      "username": username.text,
      "wilaya": selectedStateData["state"],
      "numperPhone": numperPhone.text,
    });
    if (response == Statusrequest.serverfailure) {
      return showSnackbar("خطأ".tr, "لا يوجد اتصال بالإنترنت".tr, Colors.red);
    }
    print("Response: $response");
    statusrequest = handlingData(response);
    print("=============================== Controller $response ");
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        myServices.sharedPreferences!.setInt("id", response["user"]['id']);
        myServices.sharedPreferences!.setString(
          "email",
          response["user"]["email"],
        );
        myServices.sharedPreferences!.setString(
          "username",
          response["user"]["username"],
        );
        myServices.sharedPreferences!.setString(
          "wilaya",
          response["user"]["wilaya"],
        );
        myServices.sharedPreferences!.setString(
          "numperPhone",
          response["user"]["numperPhone"],
        );
        myServices.sharedPreferences!.setInt("user_notify_status", 1);

        myServices.sharedPreferences!.setString(
          "token",
          response["access_token"],
        );
        String imageName = response["user"]["image"] ?? "";

        String imageUrl = "${Applink.image}$imageName";

        final file = await downloadAndCacheImage(imageUrl);

        if (file != null) {
          myServices.sharedPreferences!.setString("image", file.path);
        }
        var imagepath = myServices.sharedPreferences?.getString("image");
        if (imagepath != null && imagepath.isNotEmpty) {
          final file = File(imagepath);
          if (file.existsSync()) {
            Get.find<HomecontrollerImp>().image = file;
            Get.find<HomecontrollerImp>().update();
            Get.find<ProfailecontrollerImp>().onInit();
            Get.find<ProfailecontrollerImp>().update();
          }
        }

        if (type == 1) {
          Get.put(ProfailecontrollerImp());
          print("(==============)");
          Get.back();
          Get.back();
          print("(==============)");
        } else {
          Get.offAllNamed(Approutes.navigationBar, arguments: {"uid": uid});
        }
      }
    } else {
      showTopError("حدث خطأ".tr);
      statusrequest = Statusrequest.none;
      update();
    }
    update();
  }

  @override
  void onInit() {
    final args = Get.arguments ?? {};
    uid = args['uid'];
    type = args['type'] ?? 0;
    print("============type   $type");
    super.onInit();
  }
}
