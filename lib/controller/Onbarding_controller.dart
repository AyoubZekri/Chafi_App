import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../data/datasource/statec/statec.dart';

abstract class onBardingcontrpller extends GetxController {
  next();
  Back();
  Onbardinslider(int i);
}

class OnbardingControllerImp extends onBardingcontrpller {
  late PageController pageController;
  int currenpage = 0;
  @override
  Onbardinslider(int i) {
    currenpage = i;
    print("=================$currenpage");
    update();
  }

  @override
  next() {
    if (currenpage >= onBardinglist.length - 1) {
      Get.offAllNamed(Approutes.googleSignIn);
      return;
    }

    currenpage++;
    print(currenpage);

    pageController.animateToPage(
      currenpage,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );

    update();
  }

  @override
  Back() {
    if (currenpage <= 0) return;

    currenpage--;

    pageController.animateToPage(
      currenpage,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );

    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
