import 'package:chafi/controller/Calculators/G12Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/G12BESController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxinputdatarecordeg12bes extends StatefulWidget {
  const Taxinputdatarecordeg12bes({super.key});

  @override
  State<Taxinputdatarecordeg12bes> createState() =>
      _Taxinputdatarecordeg12besState();
}

class _Taxinputdatarecordeg12besState extends State<Taxinputdatarecordeg12bes> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<G12controller>().backFromTaxInput();
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
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),

                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              CustemtextbodyMedium18(
                                color: AppColor.grey,
                                content:
                                    "يرجى إدخال قيم الضرائب المستحقة بناءً على طبيعة النشاط التجاري، مع تحديد تواريخ الإداع و الدفع  .",
                              ),

                              SizedBox(height: 40),
                              const SectionHeader(
                                title: "قيمة G12 بدون ضرائب التاخير",
                                icon: Icons.category,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'ضريبة  G12',
                                icon: Icons.factory,
                                isCurrency: true,
                                controller: controller.g12,
                              ),
                              SizedBox(height: 30),
                              const SectionHeader(
                                title: 'قيم رقم الأعمال الجبائية حسب النشاط',
                                icon: Icons.category, // أيقونة مشابهة للمثلثات
                              ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: 'بيع وإنتاج سلع',
                                  icon: Icons.factory,
                                  isCurrency: true,
                                  controller: controller.production,
                                ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: "هامش ربح المواد المدعمة",
                                  icon: Icons.architecture,
                                  isCurrency: true,
                                  controller: controller.profitmargin,
                                ),
                              if (controller.activityType == 2)
                                const SizedBox(height: 16),
                              if (controller.activityType == 2)
                                CustomInputField(
                                  label: 'إقتطاع من المصدر',
                                  icon: Icons.more_horiz,
                                  isCurrency: true,
                                  controller: controller.extractedfromSource,
                                ),
                              if (controller.activityType == 1)
                                const SizedBox(height: 16),
                              if (controller.activityType == 1)
                                CustomInputField(
                                  label: 'المقاول الذاتي',
                                  icon: Icons.more_horiz,
                                  isCurrency: true,
                                  controller: controller.selfcontractor,
                                ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: 'نشاطات أخرى',
                                  icon: Icons.more_horiz,
                                  isCurrency: true,
                                  controller: controller.otherActivity,
                                ),

                              const SizedBox(height: 32),

                              // 4. عنوان قسم التواريخ
                              const SectionHeader(
                                title: 'تواريخ الدفع والإيداع',
                                icon: Icons.calendar_month,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الايداع',
                                icon: Icons.check_circle_outline,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.dateofdepositand,
                              ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الدفع ',
                                icon: Icons.check_circle_outline,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.dateofpayment,
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
