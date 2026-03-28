import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/ResearchanddevelopmentController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Researchanddevelopment extends StatefulWidget {
  const Researchanddevelopment({super.key});

  @override
  State<Researchanddevelopment> createState() => _ResearchanddevelopmentState();
}

class _ResearchanddevelopmentState extends State<Researchanddevelopment> {
  final controller = Get.put(Researchanddevelopmentcontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Researchanddevelopmentcontroller>().Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("البحث والتطوير".tr),
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
        body: GetBuilder<Researchanddevelopmentcontroller>(
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

                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "أدخل الربح المحاسبي ليتم حساب قيمة الخصم الضريبي المسموح به",
                          ),
                          SizedBox(height: 24),

                          SectionHeader(
                            icon: Icons.receipt_long_outlined,
                            title: "ربح المحاسبي",
                          ),
                          SizedBox(height: 12),

                          CustomInputField(
                            label: "ربح المحاسبي",
                            icon: Icons.confirmation_num_outlined,
                            isCurrency: true,
                            controller: controller.accountingprofit,
                            errorText: controller.accountingprofitErorr,
                            onChanged: (value) {
                              controller.calcul();
                            },
                          ),
                          SizedBox(height: 24),

                          PenaltyCard(
                            title: "الحد الأقصى للخصم",
                            subtitle: "للبحث والتطوير",
                            amount: "2,000,000,00",
                          ),
                          SizedBox(height: 24),
                          TotalAmountCard(
                            total: controller.netTax.round(),
                            title: "قيمة الخصم",
                          ),
                          SizedBox(height: 30),
                          Custemsuberbutton(
                            content: "إنهاء".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.Back();
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
