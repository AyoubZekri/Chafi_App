import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Showvaluo extends StatefulWidget {
  const Showvaluo({super.key});

  @override
  State<Showvaluo> createState() => _ShowvaluoState();
}

class _ShowvaluoState extends State<Showvaluo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().backFromShowvaluo();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("العلوات وتعويضات".tr),
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
        body: GetBuilder<bonusesandcompensationcontroller>(
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
                      padding: EdgeInsets.all(20),
                      children: [
                        const SizedBox(height: 10),

                        /// عنوان القسم
                        SectionHeader(
                          icon: Icons.gavel_outlined,
                          title: "تفاصيل العلوات وتعويضات".tr,
                        ),

                        const SizedBox(height: 20),

                        PenaltyCard(
                          icon: Icons.account_balance_wallet_outlined,
                          title: "الأجر القاعدي".tr,
                          subtitle: "الأجر الأساسي".tr,
                          amount: controller.Basicwage.toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          icon: Icons.location_on_outlined,
                          title: "علاوة المنطقة".tr,
                          subtitle: "تعويض مرتبط بالمنطقة الجغرافية".tr,
                          amount: controller.zoon
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        PenaltyCard(
                          icon: Icons.percent_outlined,
                          title: "الاشتراك".tr,
                          subtitle: "الخاصة بالضمان الاجتماعي".tr,
                          amount: controller.person9
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.payments_outlined,
                          title: "الدخل الخاضع".tr,
                          subtitle: "الخاضع للضريبة بعد الإضافات".tr,
                          amount: controller.grossincome
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.trending_down_outlined,
                          title: "التخفيض الأول".tr,
                          subtitle: "المبلغ الإضافي الناتج عن تأخر السداد".tr,
                          amount: controller.discount1
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.volunteer_activism_outlined,
                          title: "التخفيض الثاني".tr,
                          subtitle: controller.personscondition == 6
                              ? "دخل الضعيف".tr
                              : "لذوي الاحتياجات والمتقاعدين".tr,
                          amount: controller.discount2
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 24),

                        /// المجموع الكلي
                        TotalAmountCard(total: controller.discount2.toInt()),

                        const SizedBox(height: 30),

                        /// زر إنهاء
                        Custemsuberbutton(
                          content: "إنهاء".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.resetAll();
                          },
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
