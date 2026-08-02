import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class CacobatphScreen extends StatefulWidget {
  const CacobatphScreen({super.key});

  @override
  State<CacobatphScreen> createState() => _CacobatphScreenState();
}

class _CacobatphScreenState extends State<CacobatphScreen> {
  final controller = Get.put(bonusesandcompensationcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.typography,
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
                  height: double.infinity,
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
                          content: "is_subject_to_cacobatph".tr,
                          color: AppColor.black,
                        ),
                        const SizedBox(height: 50),
                        Cardpersontype(
                          padding: 20,
                          marginb: 20,
                          index: 1,
                          selectedPerson: controller.isCacobatph ? 1 : 0,
                          onTap: () {
                            controller.selectedCacobatph(true);
                          },
                          title: "yes_subject".tr,
                        ),
                        Cardpersontype(
                          padding: 20,
                          marginb: 20,
                          index: 0,
                          selectedPerson: controller.isCacobatph ? 1 : 0,
                          onTap: () {
                            controller.selectedCacobatph(false);
                          },
                          title: "لا",
                        ),
                        const SizedBox(height: 50),
                        Custemsuberbutton(
                          onPressed: () {
                            controller.gotoAccountType();
                          },
                          content: "next".tr,
                          color: AppColor.typography,
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
    );
  }
}
