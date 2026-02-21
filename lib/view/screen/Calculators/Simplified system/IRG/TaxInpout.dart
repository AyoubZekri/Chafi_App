import 'package:chafi/controller/Calculators/SimplifiedsystemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxinpout extends StatefulWidget {
  const Taxinpout({super.key});

  @override
  State<Taxinpout> createState() => _TaxinpoutState();
}

class _TaxinpoutState extends State<Taxinpout> {
  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());
    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromTaxInput();
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
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),

                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              CustemtextbodyMedium18(
                                color: AppColor.grey,
                                content:
                                    "يرجى إدخال قيمة النتيجة الجبائية ، مع تحديد تواريخ الدفع المقررة بدقة.".tr,
                              ),

                              SizedBox(height: 40),

                               SectionHeader(
                                title: "النتيجة الجبائية".tr,
                                icon: Icons.analytics_outlined,
                              ),
                              const SizedBox(height: 16),

                              CustomInputField(
                                label: "النتيجة الجبائية".tr,
                                icon: Icons.request_quote_outlined,
                                isCurrency: true,
                                controller: controller.production,
                                errorText: controller.productionErorr,
                              ),
                              const SizedBox(height: 32),

                              // 4. عنوان قسم التواريخ
                               SectionHeader(
                                title: 'تواريخ الدفع والإيداع'.tr,
                                icon: Icons.calendar_month,
                              ),
                              const SizedBox(height: 16),

                              // 5. حقول التواريخ
                              if (controller.type != 3)
                                CustomInputField(
                                  label: 'تاريخ دفع التسبيقة الأولى'.tr,
                                  icon: Icons.date_range,
                                  placeholder: 'mm/dd/yyyy',
                                  isDate: true,
                                  controller: controller.advance1Date,
                                  errorText: controller.advance1DateErorr,
                                ),
                              if (controller.type != 3)
                                const SizedBox(height: 16),
                              if (controller.type != 3)
                                CustomInputField(
                                  label: 'تاريخ دفع التسبيقة الثانية'.tr,
                                  icon: Icons.date_range,
                                  placeholder: 'mm/dd/yyyy',
                                  isDate: true,
                                  controller: controller.advance2Date,
                                  errorText: controller.advance2DateErorr,
                                ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الايداع و الدفع النهائي'.tr,
                                icon: Icons.check_circle_outline,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.finalPaymentDate,
                                errorText: controller.finalPaymentDateErorr,
                              ),

                              SizedBox(height: controller.type == 3 ? 190 : 32),

                              // 6. زر الحفظ
                              Custemsuberbutton(
                                content: "التالي".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.calculateTaxperson1();
                                },
                              ),

                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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
