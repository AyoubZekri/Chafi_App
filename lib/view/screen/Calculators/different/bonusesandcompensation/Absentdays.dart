import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;

class Absentdays extends StatefulWidget {
  const Absentdays({super.key});

  @override
  State<Absentdays> createState() => _AbsentdaysState();
}

class _AbsentdaysState extends State<Absentdays> {
  final controller = Get.put(bonusesandcompensationcontroller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromAbsentDays();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("bonuses_compensations".tr),
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
        body: GetBuilder<bonusesandcompensationcontroller>(
          builder: (_) {
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
                            content: "enter_data_correctly".tr,
                          ),
                          const SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "input_absent_days".tr,
                            color: AppColor.black,
                          ),
                          const SizedBox(height: 100),
                          CustomInputField(
                            label: "absent_days_count".tr,
                            icon: Icons.event_busy,
                            controller: controller.absentDaysController,
                            errorText: controller.absentDaysError,
                          ),
                          const SizedBox(height: 50),
                          Custemsuberbutton(
                            content: "next".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoPersonscondition();
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
