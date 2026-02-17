import 'package:chafi/LinkApi.dart';
import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Institutions/InstitutioninfoController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardinfo.dart';
import '../pdf.dart';

class Institutionsinfo extends StatefulWidget {
  const Institutionsinfo({super.key});

  @override
  State<Institutionsinfo> createState() => _InstitutionsinfoState();
}

class _InstitutionsinfoState extends State<Institutionsinfo> {
  @override
  Widget build(BuildContext context) {
    Get.put(InstitutioninfocontrollerImp());
    return GetBuilder<InstitutioninfocontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("${controller.nameappar}".tr)),
          body: Handlingview(
            statusrequest: controller.statusrequest,
            widget: Container(
              child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  return Custemcardinfo(
                    isRead: controller.data[i].isread == false,
                    onOpen: () {
                      if (controller.data[i].isread == false) {
                        (controller.type == 8 || controller.type == 9)
                            ? controller.isReadeTax(controller.data[i].id)
                            : controller.type == 10
                            ? controller.isReadeDifferent(controller.data[i].id)
                            : controller.isReadeinstitution(
                                controller.data[i].id,
                              );
                      }
                    },
                    title: controller.data[i].localizedName,
                    body: controller.data[i].localizedBody,
                    Calculator: controller.data[i].calcul != null
                        ? true
                        : false,
                    Link: controller.data[i].lawId != null ? true : false,
                    onCalculator: () {
                      Get.toNamed("/${controller.data[i].calcul}");
                    },
                    onLink: () {
                      Get.to(
                        () => PdfSearchPage(
                          url: "${Applink.image}${controller.data[i].pdf}",
                          initialPage:
                              int.tryParse(
                                controller.data[i].indexLink ?? '',
                              ) ??
                              1,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
