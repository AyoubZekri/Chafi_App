import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../../core/class/handlingview.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardActeve.dart';
import '../../widget/Mypath/CustemSearchActevty.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Activitytype extends StatefulWidget {
  const Activitytype({super.key});

  @override
  State<Activitytype> createState() => _ActivitytypeState();
}

class _ActivitytypeState extends State<Activitytype> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MypathcontrollerImp>().backtonatureofactivity();
        return true;
      },

      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text("55".tr),
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
        body: GetBuilder<MypathcontrollerImp>(
          builder: (controller) {
            return RefreshIndicator(
              color: AppColor.typography,
              onRefresh: () async {
                await controller.getData();
              },
              child: Container(
                color: AppColor.typography,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      // ===== Fixed Top Section =====
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content: "61".tr,
                            ),
                            const SizedBox(height: 15),
                            LawSearchBar(
                              controller: controller.searchController,
                              onChanged: (value) {
                                controller.search(value);
                              },
                            ),
                            // const SizedBox(height: 30),
                            // CustemtextbodyMedium18(
                            //   content: "61".tr,
                            //   color: AppColor.black,
                            // ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      // ===== Scrollable List Section =====
                      Expanded(
                        child: controller.filteredData.isEmpty
                            ? Center(
                                child: Handlingview(
                                  statusrequest: controller.statusrequest,
                                  widget: const SizedBox(),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  25,
                                  10,
                                  25,
                                  180,
                                ), // Added bottom padding for buttons
                                itemCount: controller.filteredData.length,
                                itemBuilder: (context, i) {
                                  return Cardacteve(
                                    description: controller
                                        .filteredData[i]
                                        .localizedBody,
                                    padding: 20,
                                    marginb: 30,
                                    index: controller.filteredData[i].id,
                                    selectedPerson: controller.ativitytype,
                                    onTap: () {
                                      final item = controller.filteredData[i];

                                      if (item.localizedBody ==
                                              "نشاط الاستيراد المصغر" ||
                                          item.localizedBody ==
                                              "Micro-import activity") {
                                        _showModernInfoDialog(
                                          title: "تنبيه هام".tr,
                                          message:
                                              "اقتطاع من المصدر في إدارة الجمارك."
                                                  .tr,
                                          onConfirm: () {
                                            controller.selectativitytype(
                                              item.id,
                                              item.statusTax,
                                              item.taxId,
                                            );
                                          },
                                        );
                                      } else {
                                        controller.selectativitytype(
                                          item.id,
                                          item.statusTax,
                                          item.taxId,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        bottomSheet: Padding(
          padding: const EdgeInsets.all(25),
          child: Custemsuberbutton(
            content: "60".tr,
            color: AppColor.typography,
            onPressed: () {
              Get.find<MypathcontrollerImp>().taxid == 3
                  ? _showModernInfoDialog(
                      title: "تنبيه هام".tr,
                      message: Get.find<MypathcontrollerImp>().taxs3.tr,
                      onConfirm: () {
                        Get.find<MypathcontrollerImp>().adddata();
                      },
                    )
                  : Get.find<MypathcontrollerImp>().gotoTaxsystemstype();
            },
          ),
        ),
      ),
    );
  }

  void _showModernInfoDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.primarycolor.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.primarycolor.withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColor.primarycolor,
                  size: 36,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.typography,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.typography,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      child: Text(
                        "تأكيد".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        foregroundColor: AppColor.typography,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "إلغاء".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
