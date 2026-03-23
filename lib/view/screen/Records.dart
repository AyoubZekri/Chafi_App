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
  late RecordscontrollerImp controller;

  @override
  void initState() {
    controller = Get.put(RecordscontrollerImp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("سجلاتي".tr)),
      body: Obx(() {
        return RefreshIndicator(
          color: AppColor.typography,
          onRefresh: () async {
            await controller.getData();
          },
          child: Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(bottom: 80),
                itemCount: controller.data.isEmpty
                    ? 2
                    : controller.data.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: Text(
                        "90".tr,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          color: AppColor.grey,
                        ),
                      ),
                    );
                  }

                  if (controller.data.isEmpty) {
                    return SizedBox(
                      height: 500,
                      child: Handlingview(
                        statusrequest: controller.statusrequest.value,
                        widget: const SizedBox(),
                      ),
                    );
                  }

                  final item = controller.data[index - 1];

                  return BusinessCard(
                    active: item.activityName == null
                        ? item.activitSpecial == 1
                              ? "شركة مدنية".tr
                              : "شركة أخرى".tr
                        : item.localizedActivityName,
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord(item.id, item.taxId);
                    },
                    onTap: () {},
                  );
                },
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
          ),
        );
      }),
    );
  }
}
