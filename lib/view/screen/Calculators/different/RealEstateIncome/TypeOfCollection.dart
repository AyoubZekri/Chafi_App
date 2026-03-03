import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/RealestateincomeController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Typeofcollection extends StatefulWidget {
  const Typeofcollection({super.key});

  @override
  State<Typeofcollection> createState() => _TypeofcollectionState();
}

class _TypeofcollectionState extends State<Typeofcollection> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Realestateincomecontroller>().BackFromTypeofcollection();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("المداخيل العقارية".tr),
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

        body: GetBuilder<Realestateincomecontroller>(
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
                              "أدخل البيانات بدقة للحصول على نتيجة صحيحة".tr,
                        ),
                        SizedBox(height: 20),
                        CustemtextbodyMedium18(
                          content: "إختر نوع التحصيل".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 20),
                        Cardpersontype(
                          padding: 20,
                          marginb: 25,
                          index: 1,
                          title: "شهري".tr,
                          selectedPerson: controller.typeTypeofcollection,
                          onTap: () {
                            controller.selectedTypeofcollection(1);
                          },
                        ),
                        Cardpersontype(
                          padding: 20,
                          index: 2,
                          marginb: 25,
                          title: "ثلاثي".tr,
                          selectedPerson: controller.typeTypeofcollection,
                          onTap: () {
                            controller.selectedTypeofcollection(2);
                          },
                        ),
                        Cardpersontype(
                          padding: 20,
                          marginb: 25,
                          index: 3,
                          title: "سداسي".tr,
                          selectedPerson: controller.typeTypeofcollection,
                          onTap: () {
                            controller.selectedTypeofcollection(3);
                          },
                        ),
                        Cardpersontype(
                          padding: 20,
                          index: 4,
                          marginb: 25,
                          title: "سنوي".tr,
                          selectedPerson: controller.typeTypeofcollection,
                          onTap: () {
                            controller.selectedTypeofcollection(4);
                          },
                        ),

                        Cardpersontype(
                          padding: 20,
                          index: 5,
                          marginb: 25,
                          title: "لم يذكر".tr,
                          selectedPerson: controller.typeTypeofcollection,
                          onTap: () {
                            controller.selectedTypeofcollection(5);
                          },
                        ),
                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotodataIncomevalue();
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
      ),
    );
  }
}
