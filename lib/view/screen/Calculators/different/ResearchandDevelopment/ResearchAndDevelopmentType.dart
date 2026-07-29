import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/ResearchanddevelopmentController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class ResearchanddevelopmentType extends StatefulWidget {
  const ResearchanddevelopmentType({super.key});

  @override
  State<ResearchanddevelopmentType> createState() => _ResearchanddevelopmentTypeState();
}

class _ResearchanddevelopmentTypeState extends State<ResearchanddevelopmentType> {
  final controller = Get.put(Researchanddevelopmentcontroller());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("البحث والتطوير".tr),
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
      body: GetBuilder<Researchanddevelopmentcontroller>(
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
                          content: "إختر نوع المؤسسة لحساب قيمة الخصم".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 40),
                        
                        Cardpersontype(
                          padding: 30,
                          marginb: 20,
                          index: 1,
                          title: "مؤسسة ناشئة".tr,
                          selectedPerson: controller.type,
                          onTap: () {
                            controller.selectedType(1);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          marginb: 20,
                          index: 2,
                          title: "حاضنة اعمال".tr,
                          selectedPerson: controller.type,
                          onTap: () {
                            controller.selectedType(2);
                          },
                        ),
                        Cardpersontype(
                          padding: 30,
                          marginb: 30,
                          index: 3,
                          title: "مؤسسات اخرى".tr,
                          selectedPerson: controller.type,
                          onTap: () {
                            controller.selectedType(3);
                          },
                        ),
                        
                        Custemsuberbutton(
                          content: "التالي".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotocalculator(context);
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
    );
  }
}
