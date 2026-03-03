import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../../core/class/handlingview.dart';
import '../../../../../data/model/BonusModel.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Mypath/CardpersonType.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class BonusesAndCompensations extends StatefulWidget {
  const BonusesAndCompensations({super.key});

  @override
  State<BonusesAndCompensations> createState() =>
      _BonusesAndCompensationsState();
}

class _BonusesAndCompensationsState extends State<BonusesAndCompensations> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>()
            .BackFromBonusesAndCompensations();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.typography,
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
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              CustemtextbodyMedium18(
                                color: AppColor.grey,
                                content:
                                    "أدخل البيانات بدقة للحصول على نتيجة صحيحة"
                                        .tr,
                              ),
                              SizedBox(height: 40),
                              CustemtextbodyMedium18(
                                content:
                                    "إختر العلوات والتعويضات الخاضعة لي الضريبة والإشتراك لكي تدخل في الحساب"
                                        .tr,
                                color: AppColor.black,
                              ),
                              SizedBox(height: 70),
                              controller.groupedData.isEmpty
                                  ? SizedBox(
                                      height: 350,
                                      child: Handlingview(
                                        statusrequest: controller.statusrequest,
                                        widget: SizedBox(),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      itemCount:
                                          controller.groupedData[1]!.length,
                                      itemBuilder: (context, i) {
                                        final List<BonusModel> data =
                                            controller.groupedData[1] ?? [];
                                        final item = data[i];
                                        final isSelected = controller
                                            .selectedgroup
                                            .contains(item.id);
                                        return Cardpersontype(
                                          padding: 20,
                                          marginb: 30,
                                          index: data[i].id,
                                          title: data[i].localizedName,
                                          selectedPerson: isSelected
                                              ? data[i].id
                                              : 0,
                                          onTap: () {
                                            controller.togglegroup(
                                              data[i].id,
                                              !controller.selectedgroup
                                                  .contains(data[i].id),
                                            );
                                          },
                                        );
                                      },
                                    ),

                              Custemsuberbutton(
                                content: "60".tr,
                                color: AppColor.typography,
                                onPressed: () {
                                  // controller.gotoActivitytype();
                                },
                              ),

                              // const SizedBox(height: 20),

                              // Custemsuberbutton(
                              //   content: "62".tr,
                              //   color: Color(0xffE8F1FF),
                              //   color2: AppColor.brand,
                              //   onPressed: () {
                              //     controller.backtoPersonType();
                              //   },
                              // ),
                              SizedBox(height: 20),
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
