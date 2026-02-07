import 'dart:async';

import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/Statusrequest.dart';
import '../core/constant/imageassets.DART';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/Services.dart';
import '../data/datasource/Remote/PostData.dart';
import '../data/model/PostModel.dart';

abstract class Homecontroller extends GetxController {
  next();
  Onbardinslider(int i);
  gotoArticles();
}

class HomecontrollerImp extends Homecontroller {
  late PageController pageController;
  Postdata postdata = Postdata(Get.find());

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  List<PostModel> dataimg = [];
  List<PostModel> datapost = [];

  int currenpage = 0;
  late Timer _timer;

  Future<void> viewimg() async {
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": 2};

    var response = await postdata.viewdata(dat);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        dataimg.clear();
        List listdata = response['data'];
        dataimg.addAll(listdata.map((e) => PostModel.fromJson(e)));
        dataimg = List.from(dataimg);
        if (dataimg.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  Future<void> viewpost() async {
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": 1};

    var response = await postdata.viewdata(dat);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        datapost.clear();
        List listdata = response['data'];
        datapost.addAll(listdata.map((e) => PostModel.fromJson(e)));
        datapost = List.from(datapost);
        if (datapost.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  void gotoditailsarticles(int id) {
    Get.toNamed(Approutes.ditailsarticles, arguments: {"id": id});
  }

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
    viewimg();
    viewpost();
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
      if (currenpage < dataimg.length - 1) {
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
