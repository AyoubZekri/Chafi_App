import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/TextFildTaxLastyaer.dart';
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
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("حاسبة النظام المبسط".tr),
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
                          content: "أدخل ضريبة السنة الماضية او التي قبلها".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 70),
                        Textfildtaxlastyaer(
                          iconData: Icons.receipt_long,
                          hint: "ضريبة ن1 او ن2",
                          myController: controller.TaxLastyear,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        Textfildtaxlastyaer(
                          iconData: Icons.calculate,
                          hint: "أدخل الفائض",
                          myController: controller.surplus,
                          keyboardType: TextInputType.number,
                        ),
                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            if (!validInputsnak(
                              controller.TaxLastyear.text,
                              1,
                              20,
                              "numper".tr,
                            )) {
                              return;
                            }
                            controller.divideTaxToAdvance();
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
