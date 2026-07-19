import 'dart:io';

import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/Localizetion.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';
import 'package:chafi/view/screen/Law.dart';
import 'package:chafi/view/screen/Profaile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/Services.dart';
import '../view/screen/Home.dart';
import '../view/screen/Records.dart';

abstract class NavigationBarcontroller extends GetxController {
  // ignore: non_constant_identifier_names
  ChangePage(int currentpage);
}

class NavigationBarcontrollerImp extends NavigationBarcontroller {
  var currentpage = 0.obs;
  Myservices myServices = Get.find();
  var image = Rxn<File>(); // Rx nullable type
  Postdata postdata = Postdata(Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<Widget> Screen = [
    const Home(),
    const Law(),
    const Records(),
    const Profaile(),
  ];

  List IconsScreen = [
    {'icon': Icons.home},
    {'icon': Icons.article},
    {'icon': Icons.book},
    {'icon': Icons.person},
  ];

  List<Map<String, String>> get texts => [
    {'Text': "Home".tr},
    {'Text': "Articles".tr},
    {'Text': "Records".tr},
    {'Text': "Profile".tr},
  ];

  @override
  ChangePage(int i) {
    currentpage.value = i;
    update();
  }

  Future<void> addenter() async {
    update();
    if (!await checkInternet()) {
      print("=======checkInternet false=====${await checkInternet()}");
      return;
    }
    String state = await getUserState();
    var response = await postdata.adddata({
      'device_id': myServices.sharedPreferences?.getString('device_id'),
      'state': state,
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
    int numEnter = myServices.sharedPreferences?.getInt('numEnter') ?? 0;
    numEnter += 1;
    print("=============================$numEnter");
    myServices.sharedPreferences?.setInt('numEnter', numEnter);
    var imagepath = myServices.sharedPreferences?.getString("image");
    addenter();
    if (imagepath != null && imagepath.isNotEmpty) {
      final file = File(imagepath);
      if (file.existsSync()) {
        image.value = file;
      }
    }

    super.onInit();
  }
}
