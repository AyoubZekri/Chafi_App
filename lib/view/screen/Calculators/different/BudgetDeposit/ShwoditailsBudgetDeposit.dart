import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/Budgetdepositcontroller.dart';
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
        title: Text("budget_deposit".tr),
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SectionHeader(
                          icon: Icons.payments_outlined,
                          title: 'penalties_and_deposit'.tr,
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          title: "deposit_delay_tax".tr,
                          subtitle: 'deposit_delay'.tr,
                          amount: controller.deposit
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          title: "payment_delay_tax".tr,
                          subtitle: 'payment_delay'.tr,
                          amount: controller.pyment
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          title: "threat_tax".tr,
                          subtitle: 'threat'.tr,
                          amount: controller.paymentPenalty
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 24),
                        TotalAmountCard(
                          total: controller.netTax.toInt(),
                          title: "total_tax".tr,
                        ),
                        const SizedBox(height: 30),
                        Custemsuberbutton(
                          content: "finish".tr,
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
    );
  }
}
