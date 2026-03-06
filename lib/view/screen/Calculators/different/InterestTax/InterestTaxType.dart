import 'package:chafi/controller/Calculators/InterestTaxController.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Interesttaxtype extends StatefulWidget {
  const Interesttaxtype({super.key});

  @override
  State<Interesttaxtype> createState() => _InteresttaxtypeState();
}

class _InteresttaxtypeState extends State<Interesttaxtype> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Interesttaxcontroller>().BackFromInteresttaxtype();
        return true;
      },
      child: Scaffold(
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
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content: controller.interesttaxtype == 1
                              ? "إختر نوع التنازل".tr
                              : controller.interesttaxtype == 2
                              ? "إختر نوع الدخل".tr
                              : "إختر نوع الإيراد".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 100),
                        if (controller.typeTax == 1) ...[
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "عقارات مبنية وغير مبنية".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "أوراق مالية للشخص طبيعي خارج نشاطه".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(2);
                            },
                          ),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 3,
                            title: "إعادة إستثمار الفائض".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(3);
                            },
                          ),
                        ],

                        if (controller.typeTax == 2) ...[
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "أسهم وحصص الشركةوالمداخيل المماثلة".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "السندات الغير إسمية-أشخاص طبيعيين".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(2);
                            },
                          ),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 3,
                            title: "السندات الغير إسمية-أشخاص معنويين".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(3);
                            },
                          ),
                        ],

                        if (controller.typeTax == 3) ...[
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "فوائد دفاتر الإدخار".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "فوائد فائضة".tr,
                            selectedPerson: controller.interesttaxtype,
                            onTap: () {
                              controller.selectedInteresttaxtype(2);
                            },
                          ),
                        ],
                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotoValuotax();
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
