import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/RealestateincomeController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Propertytype extends StatefulWidget {
  const Propertytype({super.key});

  @override
  State<Propertytype> createState() => _PropertytypeState();
}

class _PropertytypeState extends State<Propertytype> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Realestateincomecontroller>().BackFromPropertytype();
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
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content: controller.typeOvercome == 2
                              ? "إختر نوع العقار".tr
                              : "هل العقار للإستعمال السكني فقط".tr,
                          color: AppColor.black,
                        ),
                        controller.typeOvercome == 1
                            ? SizedBox(height: 100)
                            : SizedBox(height: 50),
                        if (controller.typeOvercome != 1)
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "فردي أو جماعي".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(1);
                            },
                          ),
                        if (controller.typeOvercome != 1)
                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "غير مزود بي أثاث".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(2);
                            },
                          ),
                        if (controller.typeOvercome != 1)
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 3,
                            title: "أرض فارغة".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(3);
                            },
                          ),
                        if (controller.typeOvercome != 1)
                          Cardpersontype(
                            padding: 30,
                            index: 4,
                            marginb: 25,
                            title: "للإستعمال الفلاحي فقط".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(4);
                            },
                          ),

                        if (controller.typeOvercome == 1)
                          Cardpersontype(
                            padding: 30,
                            index: 1,
                            marginb: 25,
                            title: "نعم".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(1);
                            },
                          ),
                        if (controller.typeOvercome == 1)
                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "لا".tr,
                            selectedPerson: controller.typePropertytype,
                            onTap: () {
                              controller.selectedPropertytype(2);
                            },
                          ),
                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotoTypeofcollection();
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
