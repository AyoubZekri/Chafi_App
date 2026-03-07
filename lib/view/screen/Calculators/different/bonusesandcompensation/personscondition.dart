import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Personscondition extends StatefulWidget {
  const Personscondition({super.key});

  @override
  State<Personscondition> createState() => _PersonsconditionState();
}

class _PersonsconditionState extends State<Personscondition> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromPersonscondition();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("bonuses_compensations".tr),
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
        body: GetBuilder<bonusesandcompensationcontroller>(
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
                      padding: EdgeInsets.all(20),
                      children: [
                        SizedBox(height: 20),
                        CustemtextbodyMedium18(
                          color: AppColor.grey,
                          content: "enter_data_correctly".tr,
                        ),
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content: "are_you_in_these_people".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 60),
                        Cardpersontype(
                          padding: 30,
                          marginb: 25,
                          index: 1,
                          title: "physically_disabled".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(1);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          index: 2,
                          marginb: 25,
                          title: "mentally_disabled".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(2);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          index: 3,
                          marginb: 25,
                          title: "blind".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(3);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          index: 4,
                          marginb: 25,
                          title: "deaf_mute".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(4);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          index: 5,
                          marginb: 25,
                          title: "retired_workers".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(5);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          index: 6,
                          marginb: 25,
                          title: "none_of_them".tr,
                          selectedPerson: controller.personscondition,
                          onTap: () {
                            controller.selectedpersonscondition(6);
                          },
                        ),
                        const SizedBox(height: 20),
                        Custemsuberbutton(
                          content: "next".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotoSpeciallogictype();
                          },
                        ),
                        SizedBox(height: 20),
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