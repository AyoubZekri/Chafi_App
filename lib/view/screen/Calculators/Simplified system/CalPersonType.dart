import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../widget/Button/CustemSuberButton.dart';
import '../../../widget/Mypath/CardpersonType.dart';
import '../../../widget/Text/CustemtextbodyMedium18.dart';

class CalPersontype extends StatefulWidget {
  const CalPersontype({super.key});

  @override
  State<CalPersontype> createState() => _CalPersontypeState();
}

class _CalPersontypeState extends State<CalPersontype> {
  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());
    return Scaffold(
      backgroundColor: AppColor.typography,
      appBar: AppBar(
        title: Text("حاسبة النظام الحقيقي".tr),
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

      body: GetBuilder<Simplifiedsystemcontroller>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
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
                        content: "57".tr,
                        color: AppColor.black,
                      ),
                      SizedBox(height: 70),
                      Cardpersontype(
                        padding: 30,
                        index: 1,
                        title: "58".tr,
                        selectedPerson: controller.personType,
                        onTap: () {
                          controller.selectedPerson(1);
                        },
                      ),

                      Cardpersontype(
                        padding: 30,
                        index: 2,
                        title: "59".tr,
                        selectedPerson: controller.personType,
                        onTap: () {
                          controller.selectedPerson(2);
                        },
                      ),
                      const Spacer(),
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
            ],
          );
        },
      ),
    );
  }
}
