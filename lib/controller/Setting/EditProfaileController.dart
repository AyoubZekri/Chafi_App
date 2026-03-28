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
  // TextEditingController? welaya = TextEditingController();
  TextEditingController? numperphone = TextEditingController();

  File? image;
  String? selectedstate;

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

  @override
  Future<void> uploadimagefile() async {
    image = await fileuploadGallery();
    update();
  }

  void edituser() async {
    if (selectedstate == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار الولاية".tr, Colors.red);
      return;
    }
    statusrequest = Statusrequest.loadeng;
    update();
    final selectedStateData = state.firstWhere(
      (element) => element['state'] == selectedstate,
    );
    var response = await loginData.updateuser({
      "username": username!.text,
      "wilaya": selectedStateData['state'],
      "numperPhone": int.parse(numperphone!.text),
    }, image!);
    if (response == Statusrequest.serverfailure) {
      showSnackbar("خطأ".tr, "لا يوجد اتصال بالإنترنت".tr, Colors.red);
      // showTopError("لا يوجد اتصال بالإنترنت");
      statusrequest = Statusrequest.none;
      update();
      return;
    }
    print("Response: $response");
    statusrequest = handlingData(response);
    print("=============================== Controller $response ");
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        myServices.sharedPreferences!.setString("username", username!.text);
        myServices.sharedPreferences!.setString("wilaya", selectedstate!);
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

    selectedstate = myServices.sharedPreferences?.getString("wilaya") ?? "";

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
