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
