import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Recorde/RecordsController.dart';
import '../../core/class/handlingview.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/Button/CustemSuberButton.dart';
import '../widget/Records/CustemBusinessCard.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecordscontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("سجلاتي".tr)),
      body: Obx(() {
        return Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Text(
                    "90".tr,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: AppColor.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                controller.data.isEmpty
                    ? SizedBox(
                        height: 550,
                        child: Handlingview(
                          statusrequest: controller.statusrequest.value,
                          widget: SizedBox(),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.data.length,
                        itemBuilder: (context, i) {
                          final item = controller.data[i];
                          return BusinessCard(
                            active: item.activityName == null
                                ? item.activitSpecial == 1
                                      ? "شركة مدنية".tr
                                      : "شركة أخرى".tr
                                : item.localizedActivityName,
                            condition: 1,
                            ontap: () {
                              controller.gotoInfoRecord(item.id);
                            },
                          );
                        },
                      ),

                SizedBox(height: 80),
              ],
            ),
            Positioned(
              left: 15,
              right: 15,
              bottom: 20,
              child: Custemsuberbutton(
                content: "91".tr,
                color: AppColor.typography,
                onPressed: () {
                  controller.gotoMypath();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
