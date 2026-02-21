import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/view/widget/Button/CustemSuberButton.dart'
    show Custemsuberbutton;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/SimplifiedsystemController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Calculator/PrepaymentCard.dart';

class TaxPrepaymentsPage extends StatelessWidget {
  const TaxPrepaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Simplifiedsystemcontroller());

    return WillPopScope(
      onWillPop: () async {
        Get.find<Simplifiedsystemcontroller>().backFromPrepayments();
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
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              PrepaymentCard(
                                title: "تسبيقة ضريبية 1".tr,
                                subtitle: "الثلث الأول من السنة".tr,
                                fromDate: "20/02/${DateTime.now().year}",
                                toDate: "20/03/${DateTime.now().year}",
                                percentage: 30,
                                primaryColor: AppColor.typography,
                                prepaymentValue: controller.advance1!,
                              ),
                              const SizedBox(height: 12),
                              // Prepayment Card 2
                              PrepaymentCard(
                                title: "تسبيقة ضريبية 2".tr,
                                subtitle: "الثلث الثاني من السنة".tr,
                                fromDate: "20/05/${DateTime.now().year}",
                                toDate: "20/06/${DateTime.now().year}",
                                percentage: 30,
                                primaryColor: AppColor.typography,
                                prepaymentValue: controller.advance2!,
                              ),
                              const SizedBox(height: 12),
                              // Prepayment Card 3
                              if (controller.personType == 2)
                                PrepaymentCard(
                                  title: "تسبيقة ضريبية 3".tr,
                                  subtitle: "الثلث الثالث من السنة".tr,
                                  fromDate: "20/10/${DateTime.now().year}",
                                  toDate: "20/11/${DateTime.now().year}",
                                  percentage: 30,
                                  primaryColor: AppColor.typography,
                                  prepaymentValue: controller.advance3!,
                                ),
                              const SizedBox(height: 24),
                              // Surplus Section
                              if (controller.type == 2 || controller.type == 0)
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColor.typography,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ملخص الفائض".tr,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "عرض فائض متاح".tr,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        controller.surplusLeft.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "الفائض متاح للتسوية في الفترة القادمة".tr,
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                                controller.type == 2 &&
                                    controller.personType == 2
                                ? 40
                                : controller.personType == 1
                                ? 130
                                : 200,
                            bottom: 20,
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: [
                              Custemsuberbutton(
                                content: "حساب القيمة المحققة".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  controller.gotoDetective();
                                },
                              ),
                              const SizedBox(height: 12),
                              Custemsuberbutton(
                                content: "إنهاء".tr,
                                color: Color(0xffE8F1FF),
                                color2: AppColor.brand,
                                onPressed: () {
                                  controller.resetAll();
                                },
                              ),
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
