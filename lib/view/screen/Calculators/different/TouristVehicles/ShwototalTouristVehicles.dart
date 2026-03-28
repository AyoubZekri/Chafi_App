import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/TouristCehiclesController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../../core/constant/extension.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwototaltouristvehicles extends StatefulWidget {
  const Shwototaltouristvehicles({super.key});

  @override
  State<Shwototaltouristvehicles> createState() =>
      _ShwototaltouristvehiclesState();
}

class _ShwototaltouristvehiclesState extends State<Shwototaltouristvehicles> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Touristcehiclescontroller>().BackfromShow();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("المركبات السياحية".tr),
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
        body: GetBuilder<Touristcehiclescontroller>(
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
                          SizedBox(height: 20),

                          SectionHeader(
                            icon: Icons.directions_car_outlined,
                            title: 'تفاصيل المركبات'.tr,
                          ),
                          const SizedBox(height: 12),

                          PenaltyCard(
                            title: "الحد الأقصى للخصم".tr,
                            subtitle: "لكل مركبة".tr,
                            icon: Icons.rule_outlined,
                            amount: controller.type == 2
                                ? "200,000,00"
                                : "20,000,00",
                          ),
                          const SizedBox(height: 12),

                          PenaltyCard(
                            title: "مجموع كل المركبات".tr,
                            subtitle: "القيمة الإجمالية المدخلة".tr,
                            icon: Icons.summarize_outlined,
                            amount: controller.netTax
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),
                          const SizedBox(height: 12),

                          PenaltyCard(
                            title: "الجزء غير القابل للخصم".tr,
                            subtitle: controller.type == 2
                                ? "المبلغ الذي يتجاوز DA 200,000,00".tr
                                : "المبلغ الذي يتجاوز DA 20,000,00".tr,
                            icon: Icons.remove_circle_outline,
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
                          SizedBox(height: 30),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
