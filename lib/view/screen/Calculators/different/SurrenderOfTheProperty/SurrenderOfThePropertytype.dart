import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SurrenderofthepropertyController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Surrenderofthepropertytype extends StatefulWidget {
  const Surrenderofthepropertytype({super.key});

  @override
  State<Surrenderofthepropertytype> createState() =>
      _SurrenderofthepropertytypeState();
}

class _SurrenderofthepropertytypeState
    extends State<Surrenderofthepropertytype> {
  final controller = Get.put(Surrenderofthepropertycontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Surrenderofthepropertycontroller>()
            .BackFromSurrenderofthepropertytype();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("التنازل عن العقارات".tr),
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

        body: GetBuilder<Surrenderofthepropertycontroller>(
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
                            content: "هل العقار سكن رئيسي وحيد".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 100),
                          Cardpersontype(
                            padding: 30,
                            marginb: 25,
                            index: 1,
                            title: "نعم".tr,
                            selectedPerson: controller.singleResidence,
                            onTap: () {
                              controller.selectedOvercome(1);
                            },
                          ),

                          Cardpersontype(
                            padding: 30,
                            index: 2,
                            marginb: 25,
                            title: "لا".tr,
                            selectedPerson: controller.singleResidence,
                            onTap: () {
                              controller.selectedOvercome(2);
                            },
                          ),
                          SizedBox(height: 40),
                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoPropertytype();
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
