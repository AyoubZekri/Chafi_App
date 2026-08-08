import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/RealestateincomeController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Finalsubjugation extends StatefulWidget {
  const Finalsubjugation({super.key});

  @override
  State<Finalsubjugation> createState() => _FinalsubjugationState();
}

class _FinalsubjugationState extends State<Finalsubjugation> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Realestateincomecontroller>().backFromFinalsubjugation();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("مداخيل العقارية".tr),
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
        body: GetBuilder<Realestateincomecontroller>(
          builder: (controller) {
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
                          const SizedBox(height: 10),

                          /// عنوان القسم
                          SectionHeader(
                            icon: Icons.gavel_outlined,
                            title: "تفاصيل الإخضاع الضريبي النهائي".tr,
                          ),

                          const SizedBox(height: 20),

                          /// الضريبة المؤقتة (إذا موجودة)
                          if (controller.typeOvercome == 1)
                            PenaltyCard(
                              icon: Icons.schedule_outlined,
                              title: "ضريبة مؤقت".tr,
                              subtitle:
                                  "المبلغ المستحق قبل التسوية النهائية".tr,
                              amount: controller.tax
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                            ),

                          if (controller.typeOvercome == 1)
                            const SizedBox(height: 12),

                          /// الضريبة حسب السلم (إذا موجودة)
                          if (controller.typeOvercome == 1)
                            PenaltyCard(
                              icon: Icons.bar_chart_outlined,
                              title: "الضريبة حسب السلم".tr,
                              subtitle: "الضريبة الإجمالية المحسوبة".tr,
                              amount: controller.progressiveTotal
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                            ),

                          if (controller.typeOvercome == 1)
                            const SizedBox(height: 12),

                          /// الضريبة النهائية / الضريبة المعدة من المصالح الجبائية
                          PenaltyCard(
                            icon: Icons.receipt_long_outlined,
                            title: controller.typeOvercome == 1
                                ? "الضريبة المعدة من المصالح الجبائية".tr
                                : "الضريبة النهائية".tr,
                            subtitle: controller.typeOvercome == 1
                                ? "".tr
                                : "المبلغ النهائي".tr,
                            amount: controller.netTax
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          if (controller.typeOvercome == 1)
                            const SizedBox(height: 12),

                          /// التخفيض السكني
                          if (controller.typeOvercome == 1)
                            PenaltyCard(
                              icon: Icons.home_outlined,
                              title: "التخفيض السكني".tr,
                              subtitle: "نسبة التخفيض للإستعمال السكني ".tr,
                              amount: controller.discout
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                            ),

                          const SizedBox(height: 12),

                          /// غرامة التأخير
                          PenaltyCard(
                            icon: Icons.warning_amber_rounded,
                            title: "غرامة التأخير".tr,
                            subtitle: "المبلغ الإضافي الناتج عن تأخر السداد".tr,
                            amount: controller.Penalty.toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          const SizedBox(height: 24),

                          /// المجموع الكلي
                          TotalAmountCard(
                            total: controller.total.toInt(),
                            title: "الضريبة الإجمالية لدفع".tr,
                          ),

                          SizedBox(height: 30),

                          /// زر إنهاء
                          Custemsuberbutton(
                            content: "إنهاء".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.resetAll();
                            },
                          ),
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
}
