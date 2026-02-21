import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/G12BESController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwopenaltyg12bes extends StatefulWidget {
  const Shwopenaltyg12bes({super.key});

  @override
  State<Shwopenaltyg12bes> createState() => _Shwopenaltyg12besState();
}

class _Shwopenaltyg12besState extends State<Shwopenaltyg12bes> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<G12bescontroller>().backFromPenaltyDetails();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("حاسبة G12BES".tr),
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
        body: GetBuilder<G12bescontroller>(
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
                          amount: controller.penalty.toInt().toString(),
                        ),
                        const SizedBox(height: 12),

                        PenaltyCard(
                          title: "ضريبة تاخير الدفع".tr,
                          subtitle: 'تأخير الدفع'.tr,
                          amount: controller.penaltypyment.toInt().toString(),
                        ),
                        SizedBox(height: 20),

                        SectionHeader(
                          icon: Icons.receipt_long,
                          title: 'الضريبة النهائية'.tr,
                        ),
                        const SizedBox(height: 12),
                        FinalTaxCard(
                          penaltys: false,
                          title: controller.netTax > 0
                              ? "الضريبة النهائية".tr
                              : "الفائض النهائية".tr,
                          netTax: controller.netTax > 0
                              ? controller.netTax.round()
                              : (-controller.netTax).round(),
                          penalty: controller.penalty.toInt(),
                        ),

                        const SizedBox(height: 24),

                        TotalAmountCard(total: controller.total.toInt()),

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
