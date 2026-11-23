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

  /// أجاب على الأسئلة من قبل: في المرات التالية لا يظهر له زر "تخطي"
  bool get _answeredBefore =>
      myServices.sharedPreferences?.getBool("hasFeedback") ?? false;

  /// مرحلة الأسئلة حسب عدد الدخول: 1 من الدخول الأول، 2 من الرابع، 3 من السابع.
  /// نعتمد "من" وليس "يساوي" حتى لا تضيع مرحلة إذا قفز العداد
  /// (العداد يزيد أيضاً عند تسجيل الدخول من جديد)
  static int _stageOf(int numEnter) => numEnter >= 7
      ? 3
      : numEnter >= 4
      ? 2
      : numEnter >= 1
      ? 1
      : 0;

  void checkAndShowFeedback() {
    int numEnter = myServices.sharedPreferences?.getInt('numEnter') ?? 0;
    int lastFeedbackNumEnter =
        myServices.sharedPreferences?.getInt('lastFeedbackNumEnter') ?? 0;
    print("=======numEnter======$numEnter");

    // تظهر المرحلة إذا لم تُعرض بعد (أُجيب عنها أو تُخطيت)؛ التخطي يؤجلها
    // للمرحلة التالية فقط
    final stage = _stageOf(numEnter);
    if (isLoggedIn && stage > _stageOf(lastFeedbackNumEnter)) {
      Future.delayed(const Duration(seconds: 2), () {
        if (Get.isDialogOpen != true) {
          showFeedbackIntro(stage);
        }
      });
    }
  }

  /// نص التقديم قبل الأسئلة حسب المرحلة (الدخول الأول، الرابع، السابع)
  List<String> _introTexts(int stage) {
    switch (stage) {
      case 1:
        return [
          "feedback_intro_1_title",
          "feedback_intro_1_line1",
          "feedback_intro_1_line2",
          "feedback_intro_1_line3",
        ];
      case 2:
        return ["feedback_intro_4_title", "feedback_intro_4_line1"];
      default:
        return [
          "feedback_intro_7_title",
          "feedback_intro_7_line1",
          "feedback_intro_7_line2",
        ];
    }
  }

  /// رسالة تقديم قبل الأسئلة: "متابعة" تعرض الأسئلة، و"تخطي" تؤجلها
  /// للمرة القادمة (لا يظهر "تخطي" لمن أجاب من قبل)
  void showFeedbackIntro(int stage) {
    final texts = _introTexts(stage);
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          backgroundColor: AppColor.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 26, 22, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.typography.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.forum_outlined,
                    color: AppColor.typography,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  texts.first.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                    fontWeight: FontWeight.w800,
                    color: AppColor.typography,
                  ),
                ),
                const SizedBox(height: 12),
                for (final line in texts.skip(1))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      line.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.typography,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      showFeedbackDialog();
                    },
                    child: Text(
                      "متابعة".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (_answeredBefore)
                  const SizedBox(height: 10)
                else
                  TextButton(
                    onPressed: skipFeedback,
                    child: Text(
                      "تخطي".tr,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// تخطي: لا تظهر الأسئلة في هذا الدخول، وتظهر في المرة القادمة
  void skipFeedback() {
    int currentNumEnter = myServices.sharedPreferences?.getInt('numEnter') ?? 0;
    myServices.sharedPreferences?.setInt("lastFeedbackNumEnter", currentNumEnter);
    Get.back();
  }

  void showFeedbackDialog() {
    Map<int, int> selectedAnswers = {};
    Set<int> expandedQuestions = {}; // لا تفتح أي سؤال افتراضيًا

    int numEnter = myServices.sharedPreferences?.getInt('numEnter') ?? 0;

    // الأسئلة الستة: نص السؤال وخياراته كما في جدول الاستبيان؛ السادس من الدخول الرابع
    final List<Map<String, dynamic>> questions = [
      {
        "title": "كيف تقيّم عدالة توزيع العبء الضريبي في الجزائر؟".tr,
        "options": [
          {"id": 11, "name": "ضعيفة".tr},
          {"id": 12, "name": "مقبولة".tr},
          {"id": 13, "name": "جيدة".tr},
        ],
      },
      {
        "title": "كيف تصف تعاملك مع الإدارة الجبائية؟".tr,
        "options": [
          {"id": 21, "name": "متعاونة".tr},
          {"id": 22, "name": "بطيئة".tr},
          {"id": 23, "name": "معقدة".tr},
        ],
      },
      {
        "title": "ما العائق الأكبر الذي يصعّب عليك أداء التزاماتك الجبائية؟".tr,
        "options": [
          {"id": 31, "name": "تعقيد القوانين الجبائية".tr},
          {"id": 32, "name": "ارتفاع تكلفة الضرائب".tr},
          {"id": 33, "name": "غياب التوجيه والمعلومة الجبائية".tr},
        ],
      },
      {
        "title": "ما الدافع الأول الذي يجعلك تؤدي التزاماتك الجبائية؟".tr,
        "options": [
          {"id": 41, "name": "الواجب الوطني".tr},
          {"id": 42, "name": "الاستفادة من التحفيزات".tr},
          {"id": 43, "name": "تجنب العقوبات".tr},
        ],
      },
      {
        "title": "كيف تجد الخدمات الجبائية الرقمية («جبايتك»، «مساهمتك»، «طابعكم»)؟".tr,
        "options": [
          {"id": 52, "name": "سهلة وتوفر الوقت والجهد".tr},
          {"id": 54, "name": "مفيدة لكن أحتاج إلى مساعدة".tr},
          {"id": 53, "name": "صعبة الاستخدام".tr},
        ],
      },
      // السؤال السادس من المرحلة الثانية (الدخول الرابع)
      if (_stageOf(numEnter) >= 2)
        {
          "title": "ما أهم ما أفادك به التطبيق إلى الآن؟".tr,
          "options": [
            {"id": 62, "name": "صحح مفاهيمي الجبائية الخاطئة".tr},
            {"id": 63, "name": "قلّل كلفة الاستشارة".tr},
            {"id": 64, "name": "شجعني على الالتزام بواجباتي الجبائية".tr},
            {"id": 65, "name": "لم يفدني بعد".tr},
          ],
        },
    ];

    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "feedback_share_thoughts".tr,
                          style: const TextStyle(
                            color: AppColor.typography,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
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
                                    ? AppColor.typography.withOpacity(0.5)
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
                                        // نص السؤال طويل: يلتف على أكثر من سطر
                                        Expanded(
                                          child: Text(
                                            "${qIndex + 1}- ${question['title']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              height: 1.5,
                                              color: isAnswered
                                                  ? AppColor.typography
                                                  : Colors.black87,
                                            ),
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
                                            margin: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: isSelected
                                                    ? AppColor.typography
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
                                                          ? AppColor.typography
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
                                                          ? AppColor.typography
                                                          : Colors.grey,
                                                      width: 2,
                                                    ),
                                                    color: isSelected
                                                        ? AppColor.typography
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
                            onPressed: () async {
                              // بعد "متابعة" يجب الإجابة على كل الأسئلة الظاهرة (5 أو 6)
                              if (selectedAnswers.length < questions.length) {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.12,
                                            ),
                                            blurRadius: 24,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: AppColor.primarycolor
                                                  .withOpacity(0.08),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColor.primarycolor
                                                    .withOpacity(0.15),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.info_outline_rounded,
                                              color: AppColor.primarycolor,
                                              size: 36,
                                            ),
                                          ),
                                          const SizedBox(height: 18),
                                          const Text(
                                            "تنبيه",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: AppColor.typography,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "feedback_incomplete_message".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              height: 1.6,
                                              color: Color(0xFF475569),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.typography,
                                                foregroundColor: AppColor.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                              ),
                                              onPressed: () => Get.back(),
                                              child: const Text(
                                                "حسنا",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                return;
                              }
                              await sendFeedback(
                                selectedAnswers.values.toList(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.typography,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              disabledBackgroundColor: AppColor.typography
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
                        // بعد "متابعة" لا تخطي: يجب الإجابة على الأسئلة
                        const SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
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
      int currentNumEnter =
          myServices.sharedPreferences?.getInt('numEnter') ?? 0;
      myServices.sharedPreferences?.setInt(
        "lastFeedbackNumEnter",
        currentNumEnter,
      );
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

  bool isZoomed = false;

  void stopTimer() {
    isZoomed = true;
    update();
    _timer?.cancel();
    _timer = null;
  }

  void startTimer() {
    isZoomed = false;
    update();
    if (_timer == null) {
      next();
    }
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
