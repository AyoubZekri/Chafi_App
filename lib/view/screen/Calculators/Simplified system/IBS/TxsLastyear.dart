import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/Taxinpout.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Txslastyear extends StatefulWidget {
  const Txslastyear({super.key});

  @override
  State<Txslastyear> createState() => _TxslastyearState();
}

class _TxslastyearState extends State<Txslastyear> {
  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());
    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromLastYear();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
            return Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                child: Container(
                  color: AppColor.white,
                  child: ListView(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content:
                                  "أدخل البيانات بدقة للحصول على نتيجة  صحيحة"
                                      .tr,
                            ),
                            SizedBox(height: 40),
                            CustemtextbodyMedium18(
                              content:
                                  "أدخل ضريبة السنة الماضية او التي قبلها".tr,
                              color: AppColor.black,
                            ),
                            SizedBox(height: 70),
                            CustomInputField(
                              label: "ضريبة ن1 او ن2".tr,
                              icon: Icons.receipt_long,
                              isCurrency: true,
                              controller: controller.TaxLastyear,
                              errorText: controller.taxLastyearErorr,
                            ),
                            SizedBox(height: 20),
                            CustomInputField(
                              icon: Icons.calculate,
                              label: "أدخل الفائض".tr,
                              controller: controller.surplus,
                              errorText: controller.surplusErorr,
                              isCurrency: true,
                            ),
                            SizedBox(height: 130),
                            Custemsuberbutton(
                              content: "60".tr,
                              color: AppColor.typography,
                              onPressed: () {
                                controller.divideTaxToAdvance();
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
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
