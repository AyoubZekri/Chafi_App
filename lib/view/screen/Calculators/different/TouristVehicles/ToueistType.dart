import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/TouristCehiclesController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Toueisttype extends StatefulWidget {
  const Toueisttype({super.key});

  @override
  State<Toueisttype> createState() => _ToueisttypeState();
}

class _ToueisttypeState extends State<Toueisttype> {
  final controller = Get.put(Touristcehiclescontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Touristcehiclescontroller>().Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("المركبات السياحية".tr),
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

        body: GetBuilder<Touristcehiclescontroller>(
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
                            color: AppColor.grey,
                            content:
                                "أدخل البيانات بدقة للحصول على نتيجة صحيحة".tr,
                          ),
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "إختر صيانة أو كراء لحساب قيمة الخصم".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 100),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "صيانة".tr,
                            selectedPerson: controller.type,
                            onTap: () {
                              controller.selectedPerson(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "كراء".tr,
                            selectedPerson: controller.type,
                            onTap: () {
                              controller.selectedPerson(2);
                            },
                          ),
                          SizedBox(height: 30),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotodatacreate();
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
