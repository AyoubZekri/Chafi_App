import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SurrenderofthepropertyController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Surrenderofthepropertyvalue extends StatefulWidget {
  const Surrenderofthepropertyvalue({super.key});

  @override
  State<Surrenderofthepropertyvalue> createState() =>
      _SurrenderofthepropertyvalueState();
}

class _SurrenderofthepropertyvalueState
    extends State<Surrenderofthepropertyvalue> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Surrenderofthepropertycontroller>()
            .BackFromSurrenderofthepropertyvalue();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("التنازل عن العقارات".tr),
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
        body: GetBuilder<Surrenderofthepropertycontroller>(
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
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [

                        const SizedBox(height: 20),

                        CustemtextbodyMedium18(
                          color: AppColor.grey,
                          content: "أدخل معلومات التنازل العقاري".tr,
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
                          label: "سعر إقتناء العقار".tr,
                          icon: Icons.attach_money,
                          isCurrency: true,
                          controller: controller.sellingprice,
                          errorText: controller.sellingpriceErorr,
                        ),

                        const SizedBox(height: 16),

                        CustomInputField(
                          label: "سعر تنازل العقار".tr,
                          icon: Icons.sell_outlined,
                          isCurrency: true,
                          controller: controller.purchaseprice,
                          errorText: controller.purchasepriceErorr,
                        ),

                        const SizedBox(height: 16),

                        CustomInputField(
                          label: "مصاريف الإقتناء".tr,
                          icon: Icons.account_balance_wallet_outlined,
                          isCurrency: true,
                          controller: controller.sellingexpenses,
                          errorText: controller.sellingexpensesErorr,
                        ),

                        const SizedBox(height: 16),

                        CustomInputField(
                          label: "مصاريف التنازل".tr,
                          icon: Icons.request_quote_outlined,
                          isCurrency: true,
                          controller: controller.purchaseexpenses,
                          errorText: controller.purchaseexpensesErorr,
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

                        const SizedBox(height: 80),

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
            );
          },
        ),
      ),
    );
  }
}