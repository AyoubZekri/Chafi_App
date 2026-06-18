import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controller/Calculators/FlatratesystemController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Shwoflatratesystem extends StatefulWidget {
  const Shwoflatratesystem({super.key});

  @override
  State<Shwoflatratesystem> createState() => _ShwoflatratesystemState();
}

class _ShwoflatratesystemState extends State<Shwoflatratesystem> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<FlatratesystemController>().backFromShwovalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("النتائج".tr),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 22,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
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
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  child: Container(
                    color: AppColor.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          SectionHeader(
                            icon: Icons.analytics_outlined,
                            title: "النتائج المفصلة".tr,
                          ),
                          const SizedBox(height: 25),
                          PenaltyCard(
                            icon: Icons.money,
                            title: "الضريبة الجزافية الوحيدة".tr,
                            subtitle: "",
                            amount: controller.singleTax
                                .toInt()
                                .formatCustomint()
                                .toString(),
                          ),
                          const SizedBox(height: 30),
                          TotalAmountCard(
                            title: "المبلغ المدفوع لمصلحة الجمارك".tr,
                            total: controller.amountPaidToCustoms.toInt(),
                          ),
                          const SizedBox(height: 30),
                          Custemsuberbutton(
                            content: "إنهاء".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.resetAll();
                            },
                          ),
                          const SizedBox(height: 10),
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
