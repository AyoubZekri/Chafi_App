import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../widget/Button/CustemSuberButton.dart';
import '../../../widget/Calculator/Taxinpout.dart';
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
                    child: ListView(
                      children: [
                        const SizedBox(height: 30),

                        Container(
                          padding: const EdgeInsets.all(20),
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
                                    "أدخل البيانات بدقة للحصول على نتيجة  صحيحة"
                                        .tr,
                              ),

                              const SizedBox(height: 40),

                              CustemtextbodyMedium18(
                                content: "أدخل رأس مال الشركة".tr,
                                color: AppColor.black,
                              ),

                              const SizedBox(height: 70),

                              CustomInputField(
                                icon: Icons.account_balance_wallet_outlined,
                                controller: controller.capital,
                                label: "رأس المال".tr,
                                errorText: controller.capitalErorr,
                                isCurrency: true,
                              ),

                              const SizedBox(height: 260),

                              Custemsuberbutton(
                                content: "60".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.divideTaxToCapital();
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
            );
          },
        ),
      ),
    );
  }
}
