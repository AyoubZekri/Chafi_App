import 'dart:async';
import 'dart:io';
import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/services/Services.dart';
import '../data/datasource/Remote/PostData.dart';
import '../data/model/PostModel.dart';
import '../core/class/Statusrequest.dart';

abstract class Homecontroller extends GetxController {
  next();
  Onbardinslider(int i);
  gotoArticles();
}

class HomecontrollerImp extends Homecontroller {
  late PageController pageController;
  Timer? _timer;
  File? image;
  Myservices myServices = Get.find();
    bool get isLoggedIn =>
      myServices.sharedPreferences?.getString("token") != null;


  Postdata postdata = Postdata(Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<PostModel> dataimg = [];
  List<PostModel> datapost = [];
  int currenpage = 0;

  Future<void> loadPosts({
    required int type,
    required List<PostModel> targetList,
  }) async {
    update();
    var response = await postdata.getLocalPosts({"type": type});

    if (response.isNotEmpty) {
      targetList.clear();
      targetList.addAll(response.map((e) => PostModel.fromJson(e)));
      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  Future<void> viwedata({
    required int type,
    required List<PostModel> targetList,
  }) async {
    update();

    var response = await postdata.viewdata({"type": type});

    if (response.isNotEmpty) {
      targetList.clear();
      targetList.addAll(response.map((e) => PostModel.fromJson(e)));

      statusrequest = Statusrequest.success;
      if (type == 2 && _timer == null && dataimg.length > 1) {
        next();
      }
    }

    update();
  }

  @override
  void onInit() {
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

    pageController = PageController();
    loadPosts(type: 2, targetList: dataimg);
    loadPosts(type: 1, targetList: datapost);

    viwedata(type: 2, targetList: dataimg);
    viwedata(type: 1, targetList: datapost);
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;

    if (pageController.hasClients) {
      pageController.dispose();
    } else {
      pageController = PageController();
    }

    super.onClose();
  }

  next() {
    if (dataimg.length <= 1) return;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!pageController.hasClients) return; 
      currenpage = (currenpage + 1) % dataimg.length;

      pageController.animateToPage(
        currenpage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Onbardinslider(int i) {
    currenpage = i;
    update();
  }

  @override
  gotoArticles() {
    Get.toNamed(Approutes.articles);
  }

  gotoditailsarticles(int id) {
    Get.toNamed(Approutes.ditailsarticles, arguments: {"id": id});
  }
}
