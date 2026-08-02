import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Accounttype extends StatefulWidget {
  const Accounttype({super.key});

  @override
  State<Accounttype> createState() => _AccounttypeState();
}

class _AccounttypeState extends State<Accounttype> {
  final controller = Get.put(bonusesandcompensationcontroller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromAccounttype();
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
                            content: "base_working_days".tr,
                            color: AppColor.black,
                          ),
                          const SizedBox(height: 50),
                          Cardpersontype(
                            padding: 20,
                            marginb: 20,
                            index: 22,
                            title: "22_days".tr,
                            selectedPerson: int.tryParse(controller.baseWorkingDaysController.text) ?? 0,
                            onTap: () {
                              controller.baseWorkingDaysController.text = "22";
                              controller.baseWorkingDaysError = null;
                              controller.update();
                            },
                          ),
                          Cardpersontype(
                            padding: 20,
                            marginb: 20,
                            index: 26,
                            title: "26_days".tr,
                            selectedPerson: int.tryParse(controller.baseWorkingDaysController.text) ?? 0,
                            onTap: () {
                              controller.baseWorkingDaysController.text = "26";
                              controller.baseWorkingDaysError = null;
                              controller.update();
                            },
                          ),
                          Cardpersontype(
                            padding: 20,
                            marginb: 20,
                            index: 30,
                            title: "30_days".tr,
                            selectedPerson: int.tryParse(controller.baseWorkingDaysController.text) ?? 0,
                            onTap: () {
                              controller.baseWorkingDaysController.text = "30";
                              controller.baseWorkingDaysError = null;
                              controller.update();
                            },
                          ),
                          if (controller.baseWorkingDaysError != null) ...[
                            const SizedBox(height: 15),
                            Text(
                              controller.baseWorkingDaysError!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                          const SizedBox(height: 30),
                          Custemsuberbutton(
                            content: "next".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoAbsentDays();
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
