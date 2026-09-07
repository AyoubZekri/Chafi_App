import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/Calculators/G12Controller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';
import '../../../../widget/Calculator/Taxinpout.dart';

class EstablishmentDateG12 extends StatelessWidget {
  const EstablishmentDateG12({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<G12controller>();
    return WillPopScope(
      onWillPop: () async {
        controller.backFromEstablishmentDate();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("حاسبة G12".tr),
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
        body: GetBuilder<G12controller>(
          builder: (_) {
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
                          SizedBox(height: 40),
                          CustemtextbodyMedium18(
                            content: "enter_data_accurately".tr,
                            color: AppColor.grey,
                          ),
                          SizedBox(height: 50),
                          CustomInputField(
                            label: 'establishment_year'.tr,
                            icon: Icons.date_range,
                            placeholder: 'yyyy',
                            isDate: true,
                            dateFormatType: DateFormatType.year,
                            controller: controller.establishmentYear,
                            errorText: controller.establishmentYearErorr,
                          ),
                          SizedBox(height: 20),
                          CustomInputField(
                            label: 'سنة التصريح'.tr,
                            icon: Icons.event_available,
                            placeholder: 'yyyy',
                            isDate: true,
                            dateFormatType: DateFormatType.year,
                            controller: controller.dataTax,
                            errorText: controller.dataTaxErorr,
                          ),
                          SizedBox(height: 50),
                          Custemsuberbutton(
                            content: "التالي".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller
                                  .validateAndProceedFromEstablishmentDate();
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
}
