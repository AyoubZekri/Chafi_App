import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/AdvertisingAndSponsorship.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';
import '../../../../widget/Calculator/Taxinpout.dart' hide SectionHeader;
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Advertisingandsponsorship extends StatefulWidget {
  const Advertisingandsponsorship({super.key});

  @override
  State<Advertisingandsponsorship> createState() =>
      _AdvertisingandsponsorshipState();
}

class _AdvertisingandsponsorshipState extends State<Advertisingandsponsorship> {
  final controller = Get.put(Advertisingandsponsorshipcontroller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Advertisingandsponsorshipcontroller>().Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("advertising_sponsorship".tr),
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
        body: GetBuilder<Advertisingandsponsorshipcontroller>(
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
                        const SizedBox(height: 20),

                        CustemtextbodyMedium18(
                          color: AppColor.grey,
                          content: "enter_business_number".tr,
                        ),

                        const SizedBox(height: 24),

                        SectionHeader(
                          icon: Icons.receipt_long_outlined,
                          title: "business_number".tr,
                        ),

                        const SizedBox(height: 12),

                        CustomInputField(
                          label: "business_number".tr,
                          icon: Icons.confirmation_num_outlined,
                          isCurrency: true,
                          controller: controller.Businessnumber,
                          errorText: controller.BusinessnumberErorr,
                          onChanged: (value) {
                            controller.calcul();
                          },
                        ),

                        const SizedBox(height: 24),

                        PenaltyCard(
                          title: "max_deduction".tr,
                          subtitle: "ads_sponsorship".tr,
                          amount: "300,00",
                        ),

                        const SizedBox(height: 24),

                        TotalAmountCard(
                          total: controller.netTax.round(),
                          title: "deduction_value".tr,
                        ),

                        const SizedBox(height: 50),

                        Custemsuberbutton(
                          content: "finish".tr,
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