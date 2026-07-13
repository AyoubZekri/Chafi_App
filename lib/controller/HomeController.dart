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
        numEnter > 0 &&
        numEnter % 5 == 0) {
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen != true) {
          showFeedbackDialog();
        }
      });
    }
  }

  void showFeedbackDialog() {
    Map<int, int> selectedAnswers = {};
    Set<int> expandedQuestions = {}; // لا تفتح أي سؤال افتراضيًا

    final List<Map<String, dynamic>> questions = [
      {
        "title": "العدالة الضريبية".tr,
        "options": [
          {"id": 11, "name": "ضعيفة".tr},
          {"id": 12, "name": "مقبولة".tr},
          {"id": 13, "name": "جيدة ومحفزة".tr},
        ],
      },
      {
        "title": "العلاقة مع الادارة".tr,
        "options": [
          {"id": 21, "name": "متعاونة".tr},
          {"id": 22, "name": "بطيئة".tr},
          {"id": 23, "name": "صارمة ومعقدة".tr},
        ],
      },
      {
        "title": "عوائق الامتثال".tr,
        "options": [
          {"id": 31, "name": "تعقيد القوانين الجبائية".tr},
          {"id": 32, "name": "ارتفاع تكلفة الضرائب".tr},
          {"id": 33, "name": "غياب التوجيه".tr},
        ],
      },
      {
        "title": "الدافع نحو الامتثال".tr,
        "options": [
          {"id": 41, "name": "واجب وطني".tr},
          {"id": 42, "name": "الاستفادة من التحفيزات".tr},
          {"id": 43, "name": "تجنب العقوبات".tr},
        ],
      },
      {
        "title": "أثر الرقمنة".tr,
        "options": [
          {"id": 51, "name": "ضرورة للعمل".tr},
          {"id": 52, "name": "توفر الوقت والجهد".tr},
          {"id": 53, "name": "صعبة الاستخدام".tr},
        ],
      },
      {
        "title": "كيف ساعدك شافي".tr,
        "options": [
          {"id": 61, "name": "بسط القوانين الجبائية".tr},
          {"id": 62, "name": "صحح المفاهيم الخاطئة".tr},
          {"id": 63, "name": "قلل كلفة الاستشارة".tr},
          {"id": 64, "name": "تعزيز وتحفيز على الامتثال".tr},
        ],
      },
    ];

    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                  const SizedBox(height: 10),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: questions.length,
                      itemBuilder: (context, qIndex) {
                        final question = questions[qIndex];
                        bool isExpanded = expandedQuestions.contains(qIndex);
                        bool isAnswered = selectedAnswers.containsKey(qIndex);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isAnswered
                                  ? AppColor.primarycolor.withOpacity(0.5)
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    if (isExpanded) {
                                      expandedQuestions.remove(qIndex);
                                    } else {
                                      expandedQuestions.add(qIndex);
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,                        
                                    children: [
                                    
                                     Text(
                                          "${qIndex + 1}- ${question['title']}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: isAnswered
                                                ? AppColor.primarycolor
                                                : Colors.black87,
                                          ),
                                        
                                        ),
                                      
                                    ],
                                  ),
                                ),
                              ),
                              if (isExpanded)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                  ),
                                  child: Column(
                                    children: ((question['options'] as List).map((
                                      option,
                                    ) {
                                      bool isSelected =
                                          selectedAnswers[qIndex] ==
                                          option['id'];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedAnswers[qIndex] =
                                                option['id'];
                                            // اختياري: إغلاق السؤال عند اختيار الإجابة والانتقال للتالي
                                            // expandedQuestions.remove(qIndex);
                                            // if (qIndex + 1 < questions.length) expandedQuestions.add(qIndex + 1);
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColor.primarycolor
                                                  : Colors.transparent,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  option['name'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.w500,
                                                    color: isSelected
                                                        ? AppColor.primarycolor
                                                        : Colors.black87,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
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
                                                    ? Center(
                                                        child: Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              const BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                        ),
                                                      )
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList()),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Buttons
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: selectedAnswers.isEmpty
                              ? null
                              : () async {
                                  await sendFeedback(
                                    selectedAnswers.values.toList(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primarycolor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
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
