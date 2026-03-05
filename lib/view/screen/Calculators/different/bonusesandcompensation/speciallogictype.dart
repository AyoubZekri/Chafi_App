import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Speciallogictype extends StatefulWidget {
  const Speciallogictype({super.key});

  @override
  State<Speciallogictype> createState() => _SpeciallogictypeState();
}

class _SpeciallogictypeState extends State<Speciallogictype> {
  final controller = Get.put(bonusesandcompensationcontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromSpeciallogictype();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("العلوات وتعويضات".tr),
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

        body: GetBuilder<bonusesandcompensationcontroller>(
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
                          content:
                              "أدخل البيانات بدقة للحصول على نتيجة صحيحة".tr,
                        ),
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content: "إختر نوع علاوة المنطقة".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 100),
                        Cardpersontype(
                          padding: 30,
                          marginb: 25,
                          index: 1,
                          title: "علاوة المنطقة الجغرافية".tr,
                          selectedPerson: controller.hasspeciallogictype,
                          onTap: () {
                            controller.selectedhasspeciallogictype(1);
                          },
                        ),

                        Cardpersontype(
                          padding: 30,
                          index: 2,
                          marginb: 25,
                          title: "علاوة المنطقة المنعزلة".tr,
                          selectedPerson: controller.hasspeciallogictype,
                          onTap: () {
                            controller.selectedhasspeciallogictype(2);
                          },
                        ),
                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.gotobonusesandcompensations();
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
