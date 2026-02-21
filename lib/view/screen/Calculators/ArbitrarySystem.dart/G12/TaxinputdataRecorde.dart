import 'package:chafi/controller/Calculators/G12Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxinputdatarecorde extends StatefulWidget {
  const Taxinputdatarecorde({super.key});

  @override
  State<Taxinputdatarecorde> createState() => _TaxinputdatarecordeState();
}

class _TaxinputdatarecordeState extends State<Taxinputdatarecorde> {
  final controller = Get.put(G12controller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<G12controller>().backFromTaxInput();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("حاسبة G12".tr),
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
        body: GetBuilder<G12controller>(
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
                                    "يرجى إدخال قيم الضرائب المستحقة بناءً على طبيعة النشاط التجاري، مع تحديد تواريخ الإداع و الدفع  ."
                                        .tr,
                              ),

                              SizedBox(height: 40),

                              // 2. عنوان قسم الضرائب
                              SectionHeader(
                                title: 'قيم رقم الأعمال الجبائية حسب النشاط'.tr,
                                icon: Icons
                                    .analytics_outlined, // أيقونة مشابهة للمثلثات
                              ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: 'بيع وإنتاج سلع'.tr,
                                  icon: Icons.inventory_2_outlined,
                                  isCurrency: true,
                                  controller: controller.production,
                                  errorText: controller.productionErorr,
                                ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: "هامش ربح المواد المدعمة".tr,
                                  icon: Icons.trending_up,
                                  isCurrency: true,
                                  controller: controller.profitmargin,
                                  errorText: controller.profitmarginErorr,
                                ),
                              if (controller.activityType == 2)
                                const SizedBox(height: 16),
                              if (controller.activityType == 2)
                                CustomInputField(
                                  label: 'إقتطاع من المصدر'.tr,
                                  icon: Icons.account_balance,
                                  isCurrency: true,
                                  controller: controller.extractedfromSource,
                                  errorText:
                                      controller.extractedfromSourceErorr,
                                ),
                              if (controller.activityType == 1)
                                const SizedBox(height: 16),
                              if (controller.activityType == 1)
                                CustomInputField(
                                  label: 'المقاول الذاتي'.tr,
                                  icon: Icons.badge_outlined,
                                  isCurrency: true,
                                  controller: controller.selfcontractor,
                                  errorText: controller.selfcontractorErorr,
                                ),
                              if (controller.activityType == 3)
                                const SizedBox(height: 16),
                              if (controller.activityType == 3)
                                CustomInputField(
                                  label: 'نشاطات أخرى'.tr,
                                  icon: Icons.business_center_outlined,
                                  isCurrency: true,
                                  controller: controller.otherActivity,
                                  errorText: controller.otherActivityErorr,
                                ),

                              const SizedBox(height: 32),

                              // 4. عنوان قسم التواريخ
                              SectionHeader(
                                title: 'تواريخ الدفع والإيداع'.tr,
                                icon: Icons.event_note_outlined,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الايداع'.tr,
                                icon: Icons.event_available,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.dateofdepositand,
                                errorText: controller.dateofdepositandErorr,
                              ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: 'تاريخ الدفع'.tr,
                                icon: Icons.payments_outlined,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.dateofpayment,
                                errorText: controller.dateofpaymentErorr,
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
