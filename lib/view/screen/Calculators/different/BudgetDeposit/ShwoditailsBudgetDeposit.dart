import 'package:chafi/controller/Calculators/Budgetdepositcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/Colorapp.dart';
import '../../../../../core/constant/extension.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwoditailsbudgetdeposit extends StatefulWidget {
  const Shwoditailsbudgetdeposit({super.key});

  @override
  State<Shwoditailsbudgetdeposit> createState() =>
      _ShwoditailsbudgetdepositState();
}

class _ShwoditailsbudgetdepositState extends State<Shwoditailsbudgetdeposit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إيداع الميزانية".tr),
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
      body: GetBuilder<Budgetdepositcontroller>(
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
                        icon: Icons.payments_outlined,
                        title: 'عقوبات التأخير والإداع'.tr,
                      ),
                      const SizedBox(height: 12),

                      PenaltyCard(
                        title: "ضريبة تاخير الإداع".tr,
                        subtitle: 'تأخير الإداع'.tr,
                        amount: controller.deposit
                            .toInt()
                            .formatCustomint()
                            .toString(),
                      ),
                      const SizedBox(height: 12),

                      PenaltyCard(
                        title: "ضريبة تاخير الدفع".tr,
                        subtitle: 'تأخير الدفع'.tr,
                        amount: controller.pyment
                            .toInt()
                            .formatCustomint()
                            .toString(),
                      ),
                      const SizedBox(height: 12),

                      PenaltyCard(
                        title: "ضريبة التهديد".tr,
                        subtitle: 'التهديد'.tr,
                        amount: controller.paymentPenalty
                            .toInt()
                            .formatCustomint()
                            .toString(),
                      ),
                      const SizedBox(height: 24),

                      TotalAmountCard(
                        total: controller.netTax.toInt(),
                        title: "مجموع الضريبة".tr,
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
    );
  }
}
