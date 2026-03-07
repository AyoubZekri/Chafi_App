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
          title: Text("gifts".tr),
          titleTextStyle: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: const IconThemeData(color: AppColor.white),
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
                        const SizedBox(height: 20),

                        SectionHeader(
                          icon: Icons.card_giftcard,
                          title: 'gifts_details'.tr,
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "max_deduction".tr,
                          subtitle: "per_gift".tr,
                          amount: "1,000,00",
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "total_gifts".tr,
                          subtitle: "total_entered_value".tr,
                          amount: controller.netTax.toInt().formatCustomint().toString(),
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "non_deductible_part".tr,
                          subtitle: "amount_exceeding_limit".tr,
                          amount: controller.addreselttax.toInt().formatCustomint().toString(),
                        ),
                        const SizedBox(height: 24),

                        TotalAmountCard(
                          total: controller.total.toInt(),
                          title: "deductible_total".tr,
                        ),
                        const SizedBox(height: 90),

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
            );
          },
        ),
      ),
    );
  }
}