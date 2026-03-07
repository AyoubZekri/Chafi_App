import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/Budgetdepositcontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Inputdata extends StatefulWidget {
  const Inputdata({super.key});

  @override
  State<Inputdata> createState() => _InputdataState();
}

class _InputdataState extends State<Inputdata> {
  final controller = Get.put(Budgetdepositcontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Budgetdepositcontroller>().Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("budget_deposit".tr),
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
        body: GetBuilder<Budgetdepositcontroller>(
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
                                content: "please_enter_budget_value".tr,
                              ),

                              SizedBox(height: 40),
                              SectionHeader(
                                title: "budget".tr,
                                icon: Icons.analytics_outlined,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: "budget_value".tr,
                                icon: Icons.payments_outlined,
                                isCurrency: true,
                                controller: controller.budgetdeposit,
                                errorText: controller.budgetdepositErorr,
                              ),
                              const SizedBox(height: 32),

                              SectionHeader(
                                title: "payment_and_deposit_dates".tr,
                                icon: Icons.event_note_outlined,
                              ),
                              const SizedBox(height: 16),
                              CustomInputField(
                                label: "budget_date".tr,
                                icon: Icons.event_available,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.datebudgetdeposit,
                                errorText: controller.datebudgetdepositErorr,
                              ),

                              const SizedBox(height: 16),

                              CustomInputField(
                                label: "deposit_date".tr,
                                icon: Icons.event_available,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.datedeposit,
                                errorText: controller.datedepositErorr,
                              ),

                              const SizedBox(height: 16),
                              CustomInputField(
                                label: "payment_date".tr,
                                icon: Icons.payments_outlined,
                                placeholder: 'mm/dd/yyyy',
                                isDate: true,
                                controller: controller.datepyment,
                                errorText: controller.datepymentErorr,
                              ),

                              const SizedBox(height: 32),

                              // 6. زر الحفظ
                              Custemsuberbutton(
                                content: "next".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.calcul();
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
