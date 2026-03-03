import 'package:chafi/controller/Calculators/Budgetdepositcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/Costsguidancecontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../../core/constant/extension.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwototalguidance extends StatefulWidget {
  const Shwototalguidance({super.key});

  @override
  State<Shwototalguidance> createState() => _ShwototalguidanceState();
}

class _ShwototalguidanceState extends State<Shwototalguidance> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Costsguidancecontroller>().BackfromShow();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("الهداية".tr),
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
        body: GetBuilder<Costsguidancecontroller>(
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
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        SizedBox(height: 20),

                        SectionHeader(
                          icon: Icons.card_giftcard,
                          title: 'تفاصيل الهدايا'.tr,
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "الحد الأقصى للخصم".tr,
                          subtitle: "لكل هدية".tr,
                          amount: "1,000,00",
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "مجموع كل الهدايا".tr,
                          subtitle: "القيمة الإجمالية المدخلة".tr,
                          amount: controller.netTax
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "الجزء غير القابل للخصم".tr,
                          subtitle: "المبلغ الذي يتجاوز 1,000,00 دج".tr,
                          amount: controller.addreselttax
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 24),

                        TotalAmountCard(
                          total: controller.total.toInt(),
                          title: "مجموع القابل للخصم".tr,
                        ),
                        SizedBox(height: 90),
                        Custemsuberbutton(
                          content: "إنهاء".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.resetAll();
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
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
