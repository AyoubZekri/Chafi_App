import 'dart:io';

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

  List<Widget> Screen = [
    const Home(),
    const Records(),
    const Law(),
    const Profaile(),
  ];

  List IconsScreen = [
    {'icon': Icons.home},
    {'icon': Icons.book},
    {'icon': Icons.article},
    {'icon': Icons.person},
  ];

  List<Map<String, String>> get texts => [
    {'Text': "Home".tr},
    {'Text': "Records".tr},
    {'Text': "Articles".tr},
    {'Text': "Profile".tr},
  ];

  @override
  ChangePage(int i) {
    currentpage.value = i;
    update();
  }

  @override
  void onInit() {
    var imagepath = myServices.sharedPreferences?.getString("image");

    if (imagepath != null && imagepath.isNotEmpty) {
      final file = File(imagepath);
      if (file.existsSync()) {
        image.value = file;
      }
    }

    super.onInit();
  }
}
