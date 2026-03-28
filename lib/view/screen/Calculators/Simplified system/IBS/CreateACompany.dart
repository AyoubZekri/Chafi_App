import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/Taxinpout.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Createacompany extends StatefulWidget {
  const Createacompany({super.key});

  @override
  State<Createacompany> createState() => _CreateacompanyState();
}

class _CreateacompanyState extends State<Createacompany> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromCreateCompany();
        return true;
      },
      child: Scaffold(
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
                            content: "أدخل تاريخ إنشاء الشركة".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),
                          CustomInputField(
                            icon: Icons.event_available_outlined,
                            controller: controller.dataCreate,
                            label: "أدخل التاريخ".tr,
                            placeholder: 'mm/dd/yyyy',
                            errorText: controller.dataCreateErorr,
                            isDate: true,
                          ),
                          SizedBox(height: 60),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoAfter();
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
