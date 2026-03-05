import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/InterestTaxController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Valuotax extends StatefulWidget {
  const Valuotax({super.key});

  @override
  State<Valuotax> createState() => _ValuotaxState();
}

class _ValuotaxState extends State<Valuotax> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الطابع الجبائي".tr),
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
      body: GetBuilder<Interesttaxcontroller>(
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

                      CustemtextbodyMedium18(
                        color: AppColor.grey,
                        content: "أدخل البيانات بدقة للحصول على نتيجة صحيحة".tr,
                      ),

                      SizedBox(height: 60),

                      SectionHeader(
                        icon: Icons.receipt_long_outlined,
                        title: controller.typeTax == 1
                            ? "أدخل فائض القيمة".tr
                            : controller.typeTax == 2
                            ? "أدخل ريوع رؤوس الأموال".tr
                            : "أدخل إيرادات الودائع والفوائد".tr,
                      ),

                      const SizedBox(height: 16),

                      CustomInputField(
                        label: controller.typeTax == 1
                            ? "فائض القيمة".tr
                            : controller.typeTax == 2
                            ? "ريوع رؤوس الأموال".tr
                            : "إيرادات الودائع والفوائد".tr,
                        icon: Icons.receipt_long_outlined,
                        isCurrency: true,
                        controller: controller.fixedValueController,
                        errorText: controller.fixedValueControllerError,
                        onChanged: (value) {
                           controller.calcul();
                        },
                      ),

                      const SizedBox(height: 24),

                      TotalAmountCard(
                        total: controller.netTax.round(),
                        title: "قيمة الضريبة".tr,
                      ),

                      SizedBox(height: 110),
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
