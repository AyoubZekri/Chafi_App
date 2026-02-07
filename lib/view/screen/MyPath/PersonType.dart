import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardpersonType.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Persontype extends StatefulWidget {
  const Persontype({super.key});

  @override
  State<Persontype> createState() => _PersontypeState();
}

class _PersontypeState extends State<Persontype> {
  @override
  Widget build(BuildContext context) {
    Get.put(MypathcontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.typography,
      appBar: AppBar(
        title: Text("55".tr),
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

      body: GetBuilder<MypathcontrollerImp>(
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
                        content: "56".tr,
                      ),
                      SizedBox(height: 40),
                      CustemtextbodyMedium18(
                        content: "57".tr,
                        color: AppColor.black,
                      ),
                      SizedBox(height: 70),
                      Cardpersontype(
                        padding: 30,
                        index: 1,
                        title: "58".tr,
                        selectedPerson: controller.personType,
                        onTap: () {
                          controller.selectedPerson(1);
                        },
                      ),

                      Cardpersontype(
                        padding: 30,
                        index: 2,
                        title: "59".tr,
                        selectedPerson: controller.personType,
                        onTap: () {
                          controller.selectedPerson(2);
                        },
                      ),
                      const Spacer(),
                      Custemsuberbutton(
                        content: "60".tr,
                        color: AppColor.typography,
                        onPressed: () {
                          controller.gotoNatureofactivity();
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
