import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../../../controller/Calculators/AnnualSummaryDisclosureController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Annualsummarydisclosure extends StatefulWidget {
  const Annualsummarydisclosure({super.key});

  @override
  State<Annualsummarydisclosure> createState() =>
      _AnnualsummarydisclosureState();
}

class _AnnualsummarydisclosureState extends State<Annualsummarydisclosure> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       Get.find<Annualsummarydisclosurecontroller>().backFromAnnualsummarydisclosure();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("كشف التلخيص السنوي".tr),
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
        body: GetBuilder<Annualsummarydisclosurecontroller>(
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
                        if (controller.lossORprofit == 1)
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "يرجى إدخال النتيجة الجبائية لتحديد قيمة كشف التلخيص السنوي",
                          ),

                        SizedBox(height: 60),
                        if (controller.lossORprofit == 1)
                          SectionHeader(
                            icon: Icons.payments_outlined,
                            title: 'النتيجةالجبائية',
                          ),
                        if (controller.lossORprofit == 1)
                          const SizedBox(height: 16),
                        if (controller.lossORprofit == 1)
                          CustomInputField(
                            label: 'النتيجة الجبائية',
                            icon: Icons.factory,
                            isCurrency: true,
                            controller: controller.annualSummaryDisclosure,
                            onChanged: (value) {
                              controller.calcul();
                            },
                          ),

                        const SizedBox(height: 24),

                        TotalAmountCard(
                          total: controller.lossORprofit == 1
                              ? controller.netTax.toInt()
                              : 100000,
                          text: controller.lossORprofit == 1 ? true : false,
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
      ),
    );
  }
}
