import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/AnnualSummaryDisclosureController.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Lossorprofit extends StatefulWidget {
  const Lossorprofit({super.key});

  @override
  State<Lossorprofit> createState() => _LossorprofitState();
}

class _LossorprofitState extends State<Lossorprofit> {
  final controller = Get.put(Annualsummarydisclosurecontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Annualsummarydisclosurecontroller>().backFromLossorprofit();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
        appBar: AppBar(
          title: Text("كشف التلخيص السنوي".tr),
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

        body: GetBuilder<Annualsummarydisclosurecontroller>(
          builder: (_) {
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
                          content:
                              "أدخل البيانات بدقة للحصول على نتيجة  صحيحة".tr,
                        ),
                        SizedBox(height: 40),
                        CustemtextbodyMedium18(
                          content: "يرجى تحديد نتيجة السنة المالية".tr,
                          color: AppColor.black,
                        ),
                        SizedBox(height: 70),
                        Cardpersontype(
                          padding: 30,
                          marginb: 25,
                          index: 1,
                          title: "ربح".tr,
                          selectedPerson: controller.lossORprofit,
                          onTap: () {
                            controller.selectedPerson(1);
                          },
                        ),

                        Cardpersontype(
                          padding: 30,
                          index: 2,
                          marginb: 25,
                          title: "خسارة".tr,
                          selectedPerson: controller.lossORprofit,
                          onTap: () {
                            controller.selectedPerson(2);
                          },
                        ),

                        const Spacer(),
                        Custemsuberbutton(
                          content: "60".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.lossORprofit == 2
                                ? showTotalDialog(context)
                                : controller.gotodatacreate();
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
      ),
    );
  }

  void showTotalDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: TotalAmountCarddealog(
            total: controller.lossORprofit == 1
                ? controller.netTax.toInt()
                : 100000,
            text: controller.lossORprofit == 1 ? true : false,
          ),
        ),
      ),
    );
  }
}
