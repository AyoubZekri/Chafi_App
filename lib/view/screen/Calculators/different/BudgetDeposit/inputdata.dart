import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/Budgetdepositcontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
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
        Get.find<Budgetdepositcontroller>().resetAll();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("budget_deposit".tr),
          titleTextStyle: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: const IconThemeData(color: AppColor.white),
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "أدخل البيانات بدقة للحصول على نتيجة  صحيحة".tr,
                          ),
                          const SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "يرجى تحديد حالة الميزانية".tr,
                            color: AppColor.black,
                          ),
                          const SizedBox(height: 70),
                          
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "ربــــــــح".tr,
                            selectedPerson: controller.budgetType ?? 0,
                            onTap: () {
                              controller.setBudgetType(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "خسارة".tr,
                            selectedPerson: controller.budgetType ?? 0,
                            onTap: () {
                              controller.setBudgetType(2);
                            },
                          ),

                          const SizedBox(height: 20),

                          Custemsuberbutton(
                            content: "next".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.goToNextPage();
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
