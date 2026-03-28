import 'package:chafi/controller/Calculators/G12BESController.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Typeacteviteg12bes extends StatefulWidget {
  const Typeacteviteg12bes({super.key});

  @override
  State<Typeacteviteg12bes> createState() => _Typeacteviteg12besState();
}

class _Typeacteviteg12besState extends State<Typeacteviteg12bes> {
  final controller = Get.put(G12bescontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<G12bescontroller>().backFromTypeacteviteg12bes();
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
                          SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content:
                                "أدخل البيانات بدقة للحصول على نتيجة  صحيحة".tr,
                          ),
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "إختر نوع النشاط الخاص بك".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "مقاول ذاتي".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              controller.selectedPerson(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "إقتطاع من المصدر".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              controller.selectedPerson(2);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 3,
                            marginb: 25,
                            title: "نوع أخر".tr,
                            selectedPerson: controller.activityType,
                            onTap: () {
                              controller.selectedPerson(3);
                            },
                          ),
                          SizedBox(height: 20),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotodatacreate();
                            },
                          ),

                          SizedBox(height: 20),
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
