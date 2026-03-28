import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/WaiverofinvestmentController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Waiverofinvestmentvalue extends StatefulWidget {
  const Waiverofinvestmentvalue({super.key});

  @override
  State<Waiverofinvestmentvalue> createState() =>
      _WaiverofinvestmentvalueState();
}

class _WaiverofinvestmentvalueState extends State<Waiverofinvestmentvalue> {
  final controller = Get.put(Waiverofinvestmentcontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Waiverofinvestmentcontroller>()
            .BackFromWaiverofinvestmentvalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("التنازل عن الإستثمار".tr),
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
        body: GetBuilder<Waiverofinvestmentcontroller>(
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
                        children: [
                          const SizedBox(height: 20),

                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content: "أدخل معلومات تنازل الإستثمار".tr,
                          ),

                          const SizedBox(height: 30),

                          /// =======================
                          /// القيم المالية
                          /// =======================
                          SectionHeader(
                            icon: Icons.real_estate_agent_outlined,
                            title: "القيم المالية".tr,
                          ),

                          const SizedBox(height: 20),

                          CustomInputField(
                            label: "سعر إقتناء".tr,
                            icon: Icons.attach_money,
                            isCurrency: true,
                            controller: controller.purchaseprice,
                            errorText: controller.purchasepriceErorr,
                          ),

                          const SizedBox(height: 16),

                          CustomInputField(
                            label: "سعر تنازل".tr,
                            icon: Icons.sell_outlined,
                            isCurrency: true,
                            controller: controller.sellingprice,
                            errorText: controller.sellingpriceErorr,
                          ),

                          const SizedBox(height: 30),

                          /// =======================
                          /// التواريخ
                          /// =======================
                          SectionHeader(
                            icon: Icons.date_range_outlined,
                            title: "التواريخ".tr,
                          ),

                          const SizedBox(height: 20),

                          CustomInputField(
                            label: "تاريخ الإقتناء".tr,
                            icon: Icons.calendar_today_outlined,
                            placeholder: 'سنوات الصلاحية'.tr,
                            controller: controller.yearsofvalidity,
                            errorText: controller.yearsofvalidityErorr,
                          ),

                          const SizedBox(height: 16),

                          CustomInputField(
                            label: "تاريخ الإقتناء".tr,
                            icon: Icons.calendar_today_outlined,
                            placeholder: 'mm/dd/yyyy',
                            isDate: true,
                            controller: controller.purchasedate,
                            errorText: controller.purchasedateErorr,
                          ),

                          const SizedBox(height: 16),

                          CustomInputField(
                            label: "تاريخ التنازل".tr,
                            icon: Icons.event_available_outlined,
                            placeholder: 'mm/dd/yyyy',
                            isDate: true,
                            controller: controller.saledate,
                            errorText: controller.saledateErorr,
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
