import 'package:chafi/core/constant/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Logingoogle.dart';

class Infousercontroller extends GetxController {
  gotoNavigationBar() {}
}

class InfousercontrollerImp extends Infousercontroller {
  TextEditingController username = TextEditingController();
  TextEditingController wilaya = TextEditingController();
  TextEditingController numperPhone = TextEditingController();
  Statusrequest statusrequest = Statusrequest.none;

  LoginData loginData = LoginData(Get.find());
  Myservices myServices = Get.find();
  String? uid;
  bool isSwitched = false;
  @override
  @override
  void gotoNavigationBar() async {
    if (isSwitched == false) {
      showSnackbar("خطأ", "يجب الموافقة على الشروط والأحكام", Colors.red);
      return;
    }
    statusrequest = Statusrequest.loadeng;
    update();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("======$uid");
    print("======$fcmToken");

    var response = await loginData.loginGoogle({
      "uid": uid,
      "token": fcmToken,
      "username": username.text,
      "wilaya": wilaya.text,
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
        Get.offNamed(Approutes.navigationBar);
      }
    } else {
      showSnackbar("خطأ".tr, "حذث خطأ".tr, Colors.orange);
    }
    update();
  }

  @override
  void onInit() {
    uid = Get.arguments['uid'];

    super.onInit();
  }
}
