import 'package:chafi/controller/Calculators/G12Controller.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class CalTypeActivite extends StatefulWidget {
  const CalTypeActivite({super.key});

  @override
  State<CalTypeActivite> createState() => _CalTypeActiviteState();
}

class _CalTypeActiviteState extends State<CalTypeActivite> {
  final controller = Get.put(G12controller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<G12controller>().backFromCalTypeActivite();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("حاسبة G12".tr),
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),

        body: GetBuilder<G12controller>(
          builder: (_) {
            return Container(
              color: AppColor.typography,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),

                  child: Container(
                    color: AppColor.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "أدخل البيانات بدقة للحصول على نتيجة  صحيحة".tr,
                          ),
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "إختر نوع النشاط الخاص بك".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "مقاول ذاتي".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              _showModernInfoDialog(
                                title: "تنبيه هام".tr,
                                message:
                                    "في نشاط الإستراد المصغر إقتطاع من المصدر في إدارة الجمارك.".tr,
                                onConfirm: () {
                                  controller.selectedPerson(1);
                                },
                              );
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "إقتطاع من المصدر".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              controller.selectedPerson(2);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 3,
                            marginb: 25,
                            title: "نوع أخر".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              controller.selectedPerson(3);
                            },
                          ),
                          SizedBox(height: 20),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotodatacreate();
                            },
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showModernInfoDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
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
                  color: AppColor.primarycolor.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.primarycolor.withOpacity(0.15),
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.typography,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.typography,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      child: Text(
                        "تأكيد".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        foregroundColor: AppColor.typography,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "إلغاء".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
