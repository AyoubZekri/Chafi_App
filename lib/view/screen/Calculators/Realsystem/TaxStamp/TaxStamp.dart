import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/TaxstampController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Taxstamp extends StatefulWidget {
  const Taxstamp({super.key});

  @override
  State<Taxstamp> createState() => _TaxstampState();
}

class _TaxstampState extends State<Taxstamp> {
  final controller = Get.put(Taxstampcontroller());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         Get.find<Taxstampcontroller>().Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("الطابع الجبائي".tr),
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
        body: GetBuilder<Taxstampcontroller>(
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
                      padding: const EdgeInsets.all(20),
                      children: [
                        SizedBox(height: 20),

                        CustemtextbodyMedium18(
                          color: AppColor.grey,
                          content:
                              "يرجى إدخال  إجمالي مبلغ الفاتورة بدون طابع لتحديد قيمة الطابع الجبائي",
                        ),

                        SizedBox(height: 60),

                        SectionHeader(
                          icon: Icons.payments_outlined,
                          title: 'إجمالي مبلغ الفاتورة',
                        ),

                        const SizedBox(height: 16),

                        CustomInputField(
                          label: 'إجمالي مبلغ الفاتورة',
                          icon: Icons.factory,
                          isCurrency: true,
                          controller: controller.tasStamps,
                          onChanged: (value) {
                            controller.calcul();
                          },
                        ),

                        const SizedBox(height: 24),

                        TotalAmountCard(
                          total: controller.netTax.round(),
                          title: "قيمة الطابع الجبائي",
                        ),

                        SizedBox(height: 110),
                        Custemsuberbutton(
                          content: "إنهاء".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.Back();
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
