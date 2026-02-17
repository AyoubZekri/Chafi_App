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
          title: Text("حاسبة النظام المبسط".tr),
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
                                    "يرجى إدخال قيمة النتيجة الجبائية ، مع تحديد تواريخ الدفع المقررة بدقة.",
                              ),

                              SizedBox(height: 40),

                              const SectionHeader(
                                title: "النتيجة الجبائية",
                                icon: Icons.calendar_month,
                              ),
                              const SizedBox(height: 16),

                              CustomInputField(
                                label: "النتيجة الجبائية",
                                icon: Icons.factory,
                                isCurrency: true,
                                controller: controller.production,
                              ),
                              const SizedBox(height: 32),

                              // 4. عنوان قسم التواريخ
                              const SectionHeader(
                                title: 'تواريخ الدفع والإيداع',
                                icon: Icons.calendar_month,
                              ),
                              const SizedBox(height: 16),

                              // 5. حقول التواريخ
                              if (controller.type != 3)
                                CustomInputField(
                                  label: 'تاريخ دفع التسبيقة الأولى',
                                  icon: Icons.date_range,
                                  placeholder: 'mm/dd/yyyy',
                                  isDate: true,
                                  controller: controller.advance1Date,
                                ),
                              if (controller.type != 3)
                                const SizedBox(height: 16),
                              if (controller.type != 3)
                                CustomInputField(
                                  label: 'تاريخ دفع التسبيقة الثانية',
                                  icon: Icons.date_range,
                                  placeholder: 'mm/dd/yyyy',
                                  isDate: true,
                                  controller: controller.advance2Date,
                                ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الايداع و الدفع النهائي',
                                icon: Icons.check_circle_outline,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.finalPaymentDate,
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
