import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SurrenderofthepropertyController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwovalue extends StatefulWidget {
  const Shwovalue({super.key});

  @override
  State<Shwovalue> createState() => _ShwovalueState();
}

class _ShwovalueState extends State<Shwovalue> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Surrenderofthepropertycontroller>().backFromShwovalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("التنازل عن العقارات".tr),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 22,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),
        body: GetBuilder<Surrenderofthepropertycontroller>(
          builder: (controller) {
            return Container(
              color: AppColor.typography,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  child: Container(
                    color: AppColor.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          /// =====================
                          /// عنوان النتائج
                          /// =====================
                          SectionHeader(
                            icon: Icons.analytics_outlined,
                            title: "نتائج التنازل عن العقار".tr,
                          ),

                          const SizedBox(height: 25),

                          /// الفائض
                          PenaltyCard(
                            icon: Icons.trending_up_outlined,
                            title: "الفائض".tr,
                            subtitle: "المبلغ المستحق قبل التخفيضات".tr,
                            amount: controller.netTax
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          const SizedBox(height: 14),

                          /// التخفيض السنوي
                          PenaltyCard(
                            icon: Icons.percent_outlined,
                            title: "التخفيض السنوي".tr,
                            subtitle: "قيمة التخفيض حسب مدة الحيازة".tr,
                            amount: controller.discountyear
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          if (controller.singleResidence == 1) ...[
                            const SizedBox(height: 14),
                            PenaltyCard(
                              icon: Icons.home_work_outlined,
                              title: "تخفيض سكني وحيد".tr,
                              subtitle: "نسبة التخفيض للإستعمال السكني".tr,
                              amount: controller.discount
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                            ),
                          ],

                          const SizedBox(height: 30),

                          /// =====================
                          /// المجموع النهائي
                          /// =====================
                          TotalAmountCard(total: controller.total.toInt()),

                          const SizedBox(height: 30),

                          Custemsuberbutton(
                            content: "إنهاء".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.resetAll();
                            },
                          ),

                          const SizedBox(height: 10),
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
