import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardpersonType.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Taxsystemstypeinmypath extends StatefulWidget {
  const Taxsystemstypeinmypath({super.key});

  @override
  State<Taxsystemstypeinmypath> createState() => _TaxsystemstypeinmypathState();
}

class _TaxsystemstypeinmypathState extends State<Taxsystemstypeinmypath> {
  @override
  Widget build(BuildContext context) {
    Get.put(MypathcontrollerImp());
    return WillPopScope(
      onWillPop: () async {
        Get.find<MypathcontrollerImp>().backtoativitytype();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text("55".tr),
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
        body: GetBuilder<MypathcontrollerImp>(
          builder: (controller) {
            return ListView(
              children: [
                Container(
                  color: AppColor.typography,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content: "65".tr,
                          ),
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "66".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),

                          Cardpersontype(
                            padding: 20,
                            marginb: 30,
                            index: 0,
                            title: "نضام الجزافي".tr,
                            selectedPerson: controller.taxid,
                            onTap: () {
                              controller.selectTaxsystemstype(0);
                            },
                          ),

                          Cardpersontype(
                            padding: 20,
                            marginb: 30,
                            index: 1,
                            title: "النضام المبسط".tr,
                            selectedPerson: controller.taxid,
                            onTap: () {
                              controller.selectTaxsystemstype(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 20,
                            marginb: 30,
                            index: 2,
                            title: "نضام الحقيقي".tr,
                            selectedPerson: controller.taxid,
                            onTap: () {
                              controller.selectTaxsystemstype(2);
                            },
                          ),
                          const SizedBox(height: 20),

                          Custemsuberbutton(
                            content: "حفظ".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.adddata();
                            },
                          ),
                          const SizedBox(height: 20),
                          Custemsuberbutton(
                            content: "62".tr,
                            color: Color(0xffE8F1FF),
                            color2: AppColor.brand,
                            onPressed: () {
                              controller.backtoativitytype();
                            },
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
