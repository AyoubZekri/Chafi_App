import 'package:chafi/controller/Calculators/InterestTaxController.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxtype extends StatefulWidget {
  const Taxtype({super.key});

  @override
  State<Taxtype> createState() => _TaxtypeState();
}

class _TaxtypeState extends State<Taxtype> {
  final controller = Get.put(Interesttaxcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.typography,
      appBar: AppBar(
        title: Text("ضريبة الفوائد".tr),
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

      body: GetBuilder<Interesttaxcontroller>(
        builder: (_) {
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
                        content: "أدخل البيانات بدقة للحصول على نتيجة صحيحة".tr,
                      ),
                      SizedBox(height: 40),
                      CustemtextbodyMedium18(
                        content: "إختر نوع الضريبة".tr,
                        color: AppColor.black,
                      ),
                      SizedBox(height: 100),
                      Cardpersontype(
                        padding: 30,
                        marginb: 25,
                        index: 1,
                        title: "الضريبة على فائض القيمة".tr,
                        selectedPerson: controller.typeTax,
                        onTap: () {
                          controller.selectedtypeTax(1);
                        },
                      ),

                      Cardpersontype(
                        padding: 30,
                        index: 2,
                        marginb: 25,
                        title: "ريوع رؤوس الأموال المنقولة".tr,
                        selectedPerson: controller.typeTax,
                        onTap: () {
                          controller.selectedtypeTax(2);
                        },
                      ),
                      Cardpersontype(
                        padding: 30,
                        marginb: 25,
                        index: 3,
                        title: "إيرادات الودائع والفوائد".tr,
                        selectedPerson: controller.typeTax,
                        onTap: () {
                          controller.selectedtypeTax(3);
                        },
                      ),

                      const Spacer(),
                      Custemsuberbutton(
                        content: "60".tr,
                        color: AppColor.typography,
                        onPressed: () {
                          // controller.gotoPersonscondition();
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
