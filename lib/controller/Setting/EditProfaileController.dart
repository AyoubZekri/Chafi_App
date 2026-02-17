import 'dart:io';
import 'package:chafi/controller/HomeController.dart';
import 'package:chafi/controller/ProfaileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../LinkApi.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/SaveImage.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/uploudfiler.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Logingoogle.dart';

class Editprofailecontroller extends GetxController {
  Future<void> uploadimagefile() async {}
}

class EditprofailecontrollerImp extends Editprofailecontroller {
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  LoginData loginData = LoginData(Get.find());

  TextEditingController? username = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? welaya = TextEditingController();
  TextEditingController? numperphone = TextEditingController();
  File? image;
  @override
  Future<void> uploadimagefile() async {
    image = await fileuploadGallery(false);
    update();
  }

  void edituser() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await loginData.updateuser({
      "username": username!.text,
      "wilaya": welaya!.text,
      "numperPhone": int.parse(numperphone!.text),
    }, image!);
    if (response == Statusrequest.serverfailure) {
      return showSnackbar("خطأ".tr, "لا يوجد اتصال بالإنترنت".tr, Colors.red);
    }
    print("Response: $response");
    statusrequest = handlingData(response);
    print("=============================== Controller $response ");
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        myServices.sharedPreferences!.setString("username", username!.text);
        myServices.sharedPreferences!.setString("wilaya", welaya!.text);
        myServices.sharedPreferences!.setString(
          "numperPhone",
          numperphone!.text,
        );
        String imageName = response["user"]["image"] ?? "";
        print("===========$imageName");
        String imageUrl = "${Applink.image}$imageName";
        print("===========$imageUrl");
        final file = await downloadAndCacheImage(imageUrl);
        print("===========$file");
        if (file != null) {
          myServices.sharedPreferences!.setString("image", file.path);
        }

        var imagepath = myServices.sharedPreferences?.getString("image");
        if (imagepath != null && imagepath.isNotEmpty) {
          final file = File(imagepath);
          if (file.existsSync()) {
            image = file;
            Get.find<ProfailecontrollerImp>().image = file;
            Get.find<HomecontrollerImp>().image = file;
            Get.find<ProfailecontrollerImp>().update();
          } else {
            image = null;
          }
        } else {
          image = null;
        }
        Get.back();
      }
    } else {
      showSnackbar("خطأ".tr, "حدث خطأ".tr, Colors.orange);
    }
    update();
  }

  @override
  void onInit() {
    username?.text = myServices.sharedPreferences?.getString("username") ?? "";

    email?.text = myServices.sharedPreferences?.getString("email") ?? "";

    welaya?.text = myServices.sharedPreferences?.getString("wilaya") ?? "";

    numperphone?.text =
        myServices.sharedPreferences?.getString("numperPhone") ?? "";

    var imagepath = myServices.sharedPreferences?.getString("image");
    print("=============$imagepath");

    if (imagepath != null && imagepath.isNotEmpty) {
      final file = File(imagepath);
      if (file.existsSync()) {
        image = file;
      } else {
        image = null;
      }
    } else {
      image = null;
    }
    print("=============$image");
    super.onInit();
  }
}
