import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardpersonType.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Moralactivities extends StatefulWidget {
  const Moralactivities({super.key});

  @override
  State<Moralactivities> createState() => _MoralactivitiesState();
}

class _MoralactivitiesState extends State<Moralactivities> {
  @override
  Widget build(BuildContext context) {
    Get.put(MypathcontrollerImp());
    return WillPopScope(
      onWillPop: () async {
        Get.find<MypathcontrollerImp>().backtoPersonType2();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
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
            return Container(
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
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CustemtextbodyMedium18(
                        color: AppColor.grey,
                        content: "56".tr,
                      ),
                      SizedBox(height: 40),

                      CustemtextbodyMedium18(
                        content: "63".tr,
                        color: AppColor.black,
                      ),
                      SizedBox(height: 70),
                      Cardpersontype(
                        padding: 20,
                        marginb: 50,
                        index: 1,
                        title: "شركة مدنية".tr,
                        selectedPerson: controller.moralactivities,
                        onTap: () {
                          controller.selectMoralactivities(1);
                        },
                      ),
                      Cardpersontype(
                        padding: 20,
                        marginb: 50,
                        index: 2,
                        title: "شركات أخرى".tr,
                        selectedPerson: controller.moralactivities,
                        onTap: () {
                          controller.selectMoralactivities(2);
                        },
                      ),
                      Spacer(),

                      Custemsuberbutton(
                        content: "حفظ".tr,
                        color: AppColor.typography,
                        onPressed: () {
                          controller.adddata();
                        },
                      ),

                      const SizedBox(height: 20),
                      Custemsuberbutton(
                        content: "62".tr,
                        color: Color(0xffE8F1FF),
                        color2: AppColor.brand,
                        onPressed: () {
                          controller.backtoPersonType();
                        },
                      ),

                      SizedBox(height: 20),
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
