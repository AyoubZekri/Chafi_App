import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/Recorde/InforecordController.dart';
import '../../../core/class/Statusrequest.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Records/CustemBusinessCardditails.dart';

class Inforecord extends StatefulWidget {
  const Inforecord({super.key});

  @override
  State<Inforecord> createState() => _InforecordState();
}

class _InforecordState extends State<Inforecord> {
  @override
  Widget build(BuildContext context) {
    Get.put(InforecordcontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("تفاصيل السجل")),
      body: GetBuilder<InforecordcontrollerImp>(
        builder: (controller) {
          if (controller.statusrequest == Statusrequest.loadeng) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.statusrequest == Statusrequest.failure ||
              controller.data.isEmpty) {
            return const Center(child: Text("لا توجد بيانات"));
          }

          final item = controller.data[0];

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                // ===== CONTENT (SCROLLABLE) =====
                Expanded(
                  child: ListView(
                    children: [
                      Custembusinesscardditails(
                        acteve: item.activityName == null
                            ? item.activitSpecial == 1
                                  ? "شركة مدنية".tr
                                  : "شركة أخرى"
                            : item.localizedActivityName,
                        condition: 1,
                        persontype: item.personType == 1
                            ? "شخص طبيعي"
                            : "شخص معنوي",
                        name: item.username,
                        address: item.wilaya,
                        numperTax: item.taxId == 0
                            ? "49".tr
                            : item.taxId == 1
                            ? "50".tr
                            : "48".tr,
                        codeActeve: item.codeActivity ?? "",
                      ),
                    ],
                  ),
                ),

                // ===== BUTTON FIXED AT BOTTOM =====
                const SizedBox(height: 15),
                Custemsuberbutton(
                  content: "تعديل".tr,
                  color: AppColor.typography,
                  onPressed: () {
                    if (item.taxId == 0) {
                      controller.gotoEditRecord();
                    } else {
                      Get.defaultDialog(
                        title: "ملاحظة".tr,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                          fontSize: 20,
                        ),
                        radius: 20,
                        middleText:
                            "لا يمكن تعديل النظام الجبائي بعد اعتماده.".tr,
                        confirm: SizedBox(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.typography,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "حسنًا",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      );
                   
                    }
                  },
                ),
                const SizedBox(height: 15),
                Custemsuberbutton(
                  content: "حذف".tr,
                  color: AppColor.red,
                  onPressed: () {
                    controller.daletedata();
                  },
                ),

                const SizedBox(height: 15),
              ],
            ),
          );
        },
      ),
    );
  }
}
