import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/EditrecordController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardpersonType.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Editrecord extends StatefulWidget {
  const Editrecord({super.key});

  @override
  State<Editrecord> createState() => _EditrecordState();
}

class _EditrecordState extends State<Editrecord> {
  @override
  Widget build(BuildContext context) {
    Get.put(Editrecordcontroller());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text("تعديل".tr),
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
      body: GetBuilder<Editrecordcontroller>(
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
                          content:
                              "يمكن تعديل نظامك الجبائي من خلال هذي الصفحة".tr,
                        ),
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content:
                              "إخر النظام الجبائي الجديد الخاص بي مؤسستك".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 70),

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
                            controller.ediddata();
                          },
                        ),

                        // const SizedBox(height: 20),
                        // Custemsuberbutton(
                        //   content: "62".tr,
                        //   color: Color(0xffE8F1FF),
                        //   color2: AppColor.brand,
                        //   onPressed: () {
                        //     controller.backtoativitytype();
                        //   },
                        // ),
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
    );
  }
}
