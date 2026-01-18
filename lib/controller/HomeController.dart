import 'dart:async';

import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/imageassets.DART';

abstract class Homecontroller extends GetxController {
  next();
  Onbardinslider(int i);
  gotoArticles();
}

class HomecontrollerImp extends Homecontroller {
  late PageController pageController;
  int currenpage = 0;
  late Timer _timer;

  List imgSlaider = [
    {'Image': Appimageassets.one},
    {'Image': Appimageassets.two},
    {'Image': Appimageassets.three},
  ];

  List<Map<String, dynamic>> cardServeces = [
    {
      "title": "مؤسسات",
      "img": Appimageassets.avater,
      "color": Colors.blueAccent,
    },
    {"title": "قوانين", "img": Appimageassets.one, "color": Colors.green},
    {"title": "مقالات", "img": Appimageassets.two, "color": Colors.orange},
  ];

  @override
  Onbardinslider(int i) {
    currenpage = i;
    print("=================$currenpage");
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      next();
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    pageController.dispose();
    super.onClose();
  }

  @override
  next() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currenpage < imgSlaider.length - 1) {
        currenpage++;
      } else {
        currenpage = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          currenpage,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
        );
      }

      update();
    });
  }

  @override
  gotoArticles() {
    Get.toNamed(Approutes.articles);
  }
}
