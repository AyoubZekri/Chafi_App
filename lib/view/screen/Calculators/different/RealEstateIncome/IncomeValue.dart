import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/RealestateincomeController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Incomevalue extends StatefulWidget {
  const Incomevalue({super.key});

  @override
  State<Incomevalue> createState() => _IncomevalueState();
}

class _IncomevalueState extends State<Incomevalue> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Realestateincomecontroller>().BackFromIncomevalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("المداخيل العقارية".tr),
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
        body: GetBuilder<Realestateincomecontroller>(
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
                          SizedBox(height: 20),

                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content: "أدخل قيمة الدخل العقاري".tr,
                          ),

                          SizedBox(height: 30),

                          SectionHeader(
                            icon: Icons.receipt_long_outlined,
                            title: "قيمة الدخل العقاري".tr,
                          ),

                          const SizedBox(height: 16),

                          CustomInputField(
                            label: "أدخل قيمة الدخل العقاري".tr,
                            icon: Icons.receipt_long_outlined,
                            isCurrency: true,
                            controller: controller.incmevalue,
                            errorText: controller.incmevalueErorr,
                          ),
                          const SizedBox(height: 24),
                          SectionHeader(
                            icon: Icons.receipt_long_outlined,
                            title: "قيمة الدخل العقاري".tr,
                          ),

                          const SizedBox(height: 16),
                          CustomInputField(
                            label: "تاريخ عقد الإيجار".tr,
                            icon: Icons.event_available,
                            placeholder: 'mm/dd/yyyy',
                            isDate: true,
                            controller: controller.dataTheContract,
                            errorText: controller.dataTheContractErorr,
                          ),

                          const SizedBox(height: 16),
                          // CustomInputField(
                          //   label: "تاريخ التحصيل".tr,
                          //   icon: Icons.receipt_long_outlined,
                          //   placeholder: 'mm/dd/yyyy',
                          //   isDate: true,
                          //   controller: controller.datacollection,
                          //   errorText: controller.datacollectionErorr,
                          // ),
                          // const SizedBox(height: 16),
                          CustomInputField(
                            label: "payment_date".tr,
                            icon: Icons.receipt_long_outlined,
                            placeholder: 'mm/dd/yyyy',
                            isDate: true,
                            controller: controller.datapayment,
                            errorText: controller.datapaymentErorr,
                          ),

                          const SizedBox(height: 40),
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
