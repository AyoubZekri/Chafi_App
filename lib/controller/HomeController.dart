import 'dart:async';
import 'dart:io';
import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constant/Colorapp.dart';
import '../core/functions/Snacpar.dart';
import '../core/services/Services.dart';
import '../data/datasource/Remote/PostData.dart';
import '../data/model/PostModel.dart';
import '../core/class/Statusrequest.dart';
import '../data/datasource/Remote/FeedbackData.dart';

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
  FeedbackData feedbackData = FeedbackData(Get.find());

  List<PostModel> dataimg = [];
  List<PostModel> datapost = [];
  int currenpage = 0;

  Future<void> loadPosts({
    required int type,
    required List<PostModel> targetList,
  }) async {
    update();
    var response = await postdata.getLocalPosts({"type": type});
    print("=================$response");
    if (response.isNotEmpty) {
      targetList.clear();
      targetList.addAll(response.map((e) => PostModel.fromJson(e)));
      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.nodata;
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

  void checkAndShowFeedback() {
    bool? hasFeedback = myServices.sharedPreferences?.getBool("hasFeedback");
    int numEnter = myServices.sharedPreferences?.getInt('numEnter') ?? 0;
    if (hasFeedback != true &&
        isLoggedIn &&
        Get.isDialogOpen != true &&
        numEnter >= 10) {
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen != true) {
          showFeedbackDialog();
        }
      });
    }
  }

  void showFeedbackDialog() {
    List<int> selectedTypes = [];
    final List<Map<String, dynamic>> options = [
      {"id": 1, "name": "feedback_easy".tr},
      {"id": 2, "name": "feedback_instructive".tr},
      {"id": 3, "name": "feedback_motivating".tr},
      {"id": 4, "name": "feedback_correcting".tr},
      {"id": 5, "name": "feedback_reassuring".tr},
    ];

    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Get.back(),
                      ),
                      Text(
                        "feedback_share_thoughts".tr,
                        style: const TextStyle(
                          color: AppColor.primarycolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 48,
                      ), // Spacer to balance the close button
                    ],
                  ),
                  // Progress Bar
                  // Container(
                  //   height: 4,
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.symmetric(vertical: 10),
                  //   decoration: BoxDecoration(
                  //     color: AppColor.primarycolor.withOpacity(0.2),
                  //     borderRadius: BorderRadius.circular(2),
                  //   ),
                  //   child: FractionallySizedBox(
                  //     alignment: Alignment.centerRight,
                  //     widthFactor: 0.7, // Visual aesthetic
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: AppColor.primarycolor,
                  //         borderRadius: BorderRadius.circular(2),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // Question
                  Text(
                    "feedback_question".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  // Subtitle
                  Text(
                    "feedback_subtitle".tr,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Options
                  ...options.map((option) {
                    bool isSelected = selectedTypes.contains(option['id']);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedTypes.remove(option['id']);
                          } else {
                            selectedTypes.add(option['id']);
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primarycolor
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? AppColor.primarycolor
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(width: 20, height: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  // Buttons
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: selectedTypes.isEmpty
                              ? null
                              : () async {
                                  await sendFeedback(selectedTypes);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primarycolor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            disabledBackgroundColor: AppColor.primarycolor
                                .withOpacity(0.5),
                          ),
                          child: Text(
                            "feedback_send_button".tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "feedback_cancel".tr,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> sendFeedback(List<int> types) async {
    statusrequest = Statusrequest.loadeng;
    update();
    var response = await feedbackData.addFeedback(types);

    print("===================$response");
    handlingData(response);
    if (response['status'] == 1 && statusrequest == Statusrequest.loadeng) {
      myServices.sharedPreferences?.setBool("hasFeedback", true);
      Get.back();
      showSnackbar("feedback_thanks".tr, "feedback_success".tr, Colors.green);
    } else {
      showSnackbar("feedback_error".tr, "feedback_error_msg".tr, Colors.red);
    }
    statusrequest = Statusrequest.success;
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
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

  Future<void> getData() async {
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
  }
}
