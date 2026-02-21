import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../../core/constant/Colorapp.dart';
import '../../../widget/Button/CustemSuberButton.dart';
import '../../../widget/Calculator/PinaltyDitails.dart';

class PenaltyDetailsScreen extends StatefulWidget {
  const PenaltyDetailsScreen({super.key});

  @override
  State<PenaltyDetailsScreen> createState() => _PenaltyDetailsScreenState();
}

class _PenaltyDetailsScreenState extends State<PenaltyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());

    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromPenaltyDetails();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("حاسبة النظام الحقيقي".tr),
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
        body: GetBuilder<Simplifiedsystemcontroller>(
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
                        if (controller.type != 3)
                          SectionHeader(
                            icon: Icons.payments_outlined,
                            title: 'عقوبات التسبيقات الضريبية'.tr,
                          ),
                        if (controller.type != 3) const SizedBox(height: 12),
                        if (controller.type != 3)
                          PenaltyCard(
                            title: 'عقوبة تأخير التسبيقة 1'.tr,
                            subtitle: 'تأخير سداد الدفعة الأولى'.tr,
                            amount: controller.penalty1.toInt().toString(),
                          ),
                        if (controller.type != 3) const SizedBox(height: 12),
                        if (controller.type != 3)
                          PenaltyCard(
                            title: 'عقوبة تأخير التسبيقة 2'.tr,
                            subtitle: 'تأخير سداد الدفعة الثانية'.tr,
                            amount: controller.penalty2.toInt().toString(),
                          ),
                        if (controller.personType != 1)
                          const SizedBox(height: 12),
                        if (controller.personType != 1)
                          PenaltyCard(
                            title: 'عقوبة تأخير التسبيقة 3'.tr,
                            subtitle: 'تأخير سداد الدفعة الثالثة'.tr,
                            amount: controller.penalty3.toInt().toString(),
                          ),
                        const SizedBox(height: 24),

                        SectionHeader(
                          icon: Icons.receipt_long,
                          title: 'الضريبة النهائية'.tr,
                        ),
                        const SizedBox(height: 12),
                        FinalTaxCard(
                          title: controller.netTax >= 0
                              ? 'الضريبة النهائية'.tr
                              : 'الفائض النهائي'.tr,
                          netTax: controller.netTax.round(),
                          penalty: controller.penaltyfinal.toInt(),
                        ),

                        const SizedBox(height: 24),

                        TotalAmountCard(total: controller.total!.toInt()),

                        SizedBox(height: controller.type == 3 ? 220 : 20),
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
