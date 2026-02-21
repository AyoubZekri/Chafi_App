import 'package:chafi/controller/Calculators/SimplifiedsystemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxinputpage extends StatefulWidget {
  const Taxinputpage({super.key});

  @override
  State<Taxinputpage> createState() => _TaxinputpageState();
}

class _TaxinputpageState extends State<Taxinputpage> {
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
                                    "يرجى إدخال قيم الضرائب المستحقة بناءً على طبيعة النشاط التجاري، مع تحديد تواريخ الدفع المقررة بدقة.".tr,
                              ),

                              SizedBox(height: 40),

                              // 2. عنوان قسم الضرائب
                             SectionHeader(
                                title: 'قيم النتيجة الجبائية حسب النشاط'.tr,
                                icon: Icons.category, // أيقونة مشابهة للمثلثات
                              ),
                              const SizedBox(height: 16),

                              CustomInputField(
                                label: 'إنتاج سلع'.tr,
                                icon: Icons.factory,
                                isCurrency: true,
                                controller: controller.production,
                                errorText: controller.productionErorr,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label:
                                    'البناء والاشغال العمومية والري والأنشطة السياحة والحمامات'.tr,
                                icon:
                                    Icons.architecture, // أيقونة مشابهة للفرجار
                                isCurrency: true,
                                controller: controller.construction,
                                errorText: controller.constructionErorr,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'نشاطات أخرى'.tr,
                                icon: Icons.more_horiz,
                                isCurrency: true,
                                controller: controller.otherActivity,
                                errorText: controller.otherActivityErorr,
                              ),

                              const SizedBox(height: 32),

                              // 4. عنوان قسم التواريخ
                               SectionHeader(
                                title: 'تواريخ الدفع والإيداع'.tr,
                                icon: Icons.calendar_month,
                              ),
                              const SizedBox(height: 16),

                              // 5. حقول التواريخ
                              CustomInputField(
                                label: 'تاريخ دفع التسبيقة الأولى'.tr,
                                icon: Icons.date_range,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.advance1Date,
                                errorText: controller.advance1DateErorr,
                              ),

                              const SizedBox(height: 16),
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
                                label: 'تاريخ دفع التسبيقة الثالثة'.tr,
                                icon: Icons.date_range,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.advance3Date,
                                errorText: controller.advance3DateErorr,
                              ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الايداع او الدفع النهائي'.tr,
                                icon: Icons.check_circle_outline,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.finalPaymentDate,
                                errorText: controller.finalPaymentDateErorr,
                              ),

                              const SizedBox(height: 32),

                              // 6. زر الحفظ
                              Custemsuberbutton(
                                content: "التالي".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.calculateTax();
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
