import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/RealestateincomeController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';
import '../../../../widget/Mypath/CardpersonType.dart';

class PeriodSelection extends StatelessWidget {
  const PeriodSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Realestateincomecontroller>().BackFromPeriodSelection();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("المداخيل العقارية".tr),
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
        body: GetBuilder<Realestateincomecontroller>(
          builder: (controller) {
            List<Widget> options = [];

            if (controller.typeTypeofcollection == 2) {
              // Quarterly
              options = [
                _buildOption(controller, 1, "الثلاثي الأول".tr),
                _buildOption(controller, 2, "الثلاثي الثاني".tr),
                _buildOption(controller, 3, "الثلاثي الثالث".tr),
                _buildOption(controller, 4, "الثلاثي الرابع".tr),
              ];
            } else if (controller.typeTypeofcollection == 3) {
              // Semi-annual
              options = [
                _buildOption(controller, 1, "السداسي الأول".tr),
                _buildOption(controller, 2, "السداسي الثاني".tr),
              ];
            } else if (controller.typeTypeofcollection == 1 ||
                controller.typeTypeofcollection == 5) {
              // Monthly or Not Mentioned
              List<String> months = [
                "جانفي",
                "فيفري",
                "مارس",
                "أفريل",
                "ماي",
                "جوان",
                "جويلية",
                "أوت",
                "سبتمبر",
                "أكتوبر",
                "نوفمبر",
                "ديسمبر",
              ];
              for (int i = 0; i < months.length; i++) {
                options.add(_buildOption(controller, i + 1, months[i].tr));
              }
            }

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
                          const SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content: "يرجى اختيار الفترة المحددة للتحصيل".tr,
                          ),
                          const SizedBox(height: 30),

                          ...options,

                          const SizedBox(height: 40),
                          Custemsuberbutton(
                            content: "التالي".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoIsAdvanceFromPeriod();
                            },
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

  Widget _buildOption(
    Realestateincomecontroller controller,
    int index,
    String title,
  ) {
    return Cardpersontype(
      index: index,
      title: title,
      selectedPerson: controller.typeSelectedPeriod,
      padding: 15,
      marginb: 16,
      onTap: () {
        controller.selectedPeriod(index);
      },
    );
  }
}
