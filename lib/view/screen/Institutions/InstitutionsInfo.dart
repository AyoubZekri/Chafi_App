import 'package:chafi/LinkApi.dart';
import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Institutions/InstitutioninfoController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardinfo.dart';
import '../pdf.dart';

class Institutionsinfo extends StatefulWidget {
  const Institutionsinfo({super.key});

  @override
  State<Institutionsinfo> createState() => _InstitutionsinfoState();
}

class _InstitutionsinfoState extends State<Institutionsinfo> {
  final controller = Get.put(InstitutioninfocontrollerImp());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstitutioninfocontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("${controller.nameappar}".tr)),
          body: RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData(); // دالة إعادة جلب البيانات
            },
            child: Handlingview(
              statusrequest: controller.statusrequest,
              widget: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
                    laws: controller.data[i].laws,
                    Calculator: controller.data[i].calcul != null,
                    Link: controller.data[i].laws!.isNotEmpty,
                    onCalculator: () {
                      handleLoginRequired(
                        () => Get.toNamed(
                          "/${controller.data[i].calcul}",
                          arguments: {'fromPage': "/institutionsinfo"},
                        ),
                      );
                    },
                    // onLawTap: (law) {
                    //   Get.to(
                    //     () => PdfSearchPage(
                    //       url: "${Applink.image}${law['pdf']}",
                    //       initialPage: law['index'] ?? 1,
                    //     ),
                    //   );
                    // },
                    // onLink: () {
                    //   Get.to(
                    //     () => PdfSearchPage(
                    //       url: "${Applink.image}${controller.data[i].pdf}",
                    //       initialPage:
                    //           int.tryParse(
                    //             controller.data[i].indexLink ?? '',
                    //           ) ??
                    //           1,
                    //     ),
                    //   );
                    // },
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
