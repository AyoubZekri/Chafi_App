import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../widget/Button/CustemSuberButton.dart';
import '../../../widget/Calculator/TextFildTaxLastyaer.dart';
import '../../../widget/Text/CustemtextbodyMedium18.dart';

class Capital extends StatefulWidget {
  const Capital({super.key});

  @override
  State<Capital> createState() => _CapitalState();
}

class _CapitalState extends State<Capital> {
  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());
    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromCapital();
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
                          content: "أدخل رأس مال الشركة".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 70),
                        Textfildtaxlastyaer(
                          iconData: Icons.money,
                          hint: "رأس المال",
                          myController: controller.capital,
                          keyboardType: TextInputType.number,
                        ),

                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            if (!validInputsnak(
                              controller.capital.text,
                              1,
                              20,
                              "numper".tr,
                            )) {
                              return;
                            }
                            controller.divideTaxToCapital();
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
