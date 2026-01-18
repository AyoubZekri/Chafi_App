import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Recorde/RecordsController.dart';
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
    Get.put(RecordscontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("سجلاتي")),
      body: GetBuilder<RecordscontrollerImp>(
        builder: (controller) {
          return Stack(
            children: [
              ListView(
                children: [
                  Padding(
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
                  ),
                  SizedBox(height: 20),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 0,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),
                  BusinessCard(
                    active: "حرفي نجار",
                    condition: 1,
                    ontap: () {
                      controller.gotoInfoRecord();
                    },
                  ),

                  BusinessCard(
                    active: "فلاحي مزارع",
                    condition: 0,
                    ontap: () {
                      controller.gotoInfoRecord();
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
                  onPressed: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
