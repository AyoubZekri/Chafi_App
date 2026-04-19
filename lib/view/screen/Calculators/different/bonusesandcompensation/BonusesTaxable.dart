import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../../core/class/handlingview.dart';
import '../../../../../data/model/BonusModel.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Bonusestaxable extends StatefulWidget {
  const Bonusestaxable({super.key});

  @override
  State<Bonusestaxable> createState() => _BonusestaxableState();
}

class _BonusestaxableState extends State<Bonusestaxable> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().BackFromBonusestaxable();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("bonuses_compensations".tr),
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content: "enter_data_correctly".tr,
                            ),

                            const SizedBox(height: 40),

                            CustemtextbodyMedium18(
                              content: "choose_taxable_bonuses_only".tr,
                              color: AppColor.black,
                            ),

                            const SizedBox(height: 70),

                            controller.statusrequest != Statusrequest.success
                                ? SizedBox(
                                    height: 350,
                                    child: Handlingview(
                                      statusrequest: controller.statusrequest,
                                      widget: const SizedBox(),
                                    ),
                                  )
                                : controller.groupedData[2] == null
                                ? SizedBox(
                                    height: 350,
                                    child: Handlingview(
                                      statusrequest: Statusrequest.nodata,
                                      widget: const SizedBox(),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount:
                                        controller.groupedData[2]!.length,
                                    itemBuilder: (context, i) {
                                      final List<BonusModel> data =
                                          controller.groupedData[2] ?? [];

                                      final item = data[i];

                                      final isSelected = controller
                                          .selectedGroups[2]!
                                          .contains(item.id);

                                      return Cardpersontype(
                                        padding: 20,
                                        marginb: 30,
                                        index: item.id,
                                        title: item.localizedName,
                                        selectedPerson: isSelected
                                            ? item.id
                                            : 0,
                                        onTap: () {
                                          controller.togglegroup(
                                            item.id,
                                            !controller.selectedGroups[2]!
                                                .contains(item.id),
                                            2,
                                          );
                                        },
                                      );
                                    },
                                  ),

                            Custemsuberbutton(
                              content: "next".tr,
                              color: AppColor.typography,
                              onPressed: () {
                                controller.gotoNonTaxableNonContributory();
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
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
