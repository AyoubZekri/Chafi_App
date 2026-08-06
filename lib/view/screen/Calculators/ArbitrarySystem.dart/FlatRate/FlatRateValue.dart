import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/Calculators/FlatratesystemController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/Taxinpout.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class FlatrateValue extends StatefulWidget {
  const FlatrateValue({super.key});

  @override
  State<FlatrateValue> createState() => _FlatrateValueState();
}

class _FlatrateValueState extends State<FlatrateValue> {
  @override
  Widget build(BuildContext context) {
    Get.put(FlatratesystemController());
    return WillPopScope(
      onWillPop: () async {
        Get.find<FlatratesystemController>().BackFromFlatRateValue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("الإقتطاع من المصدر"),
          titleTextStyle: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: const IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),
        body: GetBuilder<FlatratesystemController>(
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
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                CustemtextbodyMedium18(
                                  color: AppColor.grey,
                                  content:
                                      "أدخل البيانات بدقة للحصول على نتيجة صحيحة"
                                          .tr,
                                ),
                                const SizedBox(height: 40),
                                CustemtextbodyMedium18(
                                  content:
                                      "الإقتطاع من المصدر للمقاول الذاتي".tr,
                                  color: AppColor.black,
                                ),
                                const SizedBox(height: 50),
                                CustomInputField(
                                  icon: Icons.inventory_2_outlined,
                                  controller: controller.goodsValue,
                                  label: "قيمة السلعة".tr,
                                  errorText: controller.goodsValueErorr,
                                  isCurrency: true,
                                ),
                                const SizedBox(height: 60),
                                Custemsuberbutton(
                                  content: "حساب".tr,
                                  color: AppColor.typography,
                                  onPressed: () {
                                    controller.calcul();
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
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
