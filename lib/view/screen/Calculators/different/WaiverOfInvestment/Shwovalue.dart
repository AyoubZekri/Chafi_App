import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/WaiverofinvestmentController.dart';
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
        Get.find<Waiverofinvestmentcontroller>().backFromShwovalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("التنازل عن الإستثمار".tr),
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
        body: GetBuilder<Waiverofinvestmentcontroller>(
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
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          /// =====================
                          /// عنوان النتائج
                          /// =====================
                          SectionHeader(
                            icon: Icons.analytics_outlined,
                            title: "نتائج التنازل عن الإستثمار".tr,
                          ),

                          const SizedBox(height: 25),

                          // ======= سنوات متبقية =======
                          PenaltyCard(
                            icon: Icons.attach_money_outlined,
                            title: "سنوات متبقية".tr,
                            subtitle: "عدد السنوات المتبقية من مدة الصلاحية".tr,
                            amount: controller.remainingacquisition
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          const SizedBox(height: 14),

                          // ======= القيمة الخاضعة =======
                          PenaltyCard(
                            icon: Icons.attach_money_outlined,
                            title: "القيمة الخاضعة".tr,
                            subtitle: "القيمة التي سيتم احتسابها للضريبة".tr,
                            amount: controller.remaininSale
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),

                          const SizedBox(height: 30),

                          // ======= المجموع النهائي =======
                          TotalAmountCard(
                            title: "المجموع النهائي".tr,
                            // subtitle: "المبلغ بعد احتساب التنازل".tr,
                            total: controller.total.toInt(),
                          ),
                          const SizedBox(height: 150),

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
