import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/NavigationBarcontroller.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/NavigationBar/CustemapparbuttonList.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationBarcontrollerImp());

    return Obx(
      () => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustemapparbuttonList(),
        body: WillPopScope(
          onWillPop: () {
            Get.defaultDialog(
              backgroundColor: AppColor.white,
              title: "Alert".tr,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
              ),
              middleText: "هل تريد الخروج من التطبيق".tr,
              onConfirm: () => exit(0),
              onCancel: () => Get.back(),
              buttonColor: AppColor.typography,
              confirmTextColor: AppColor.white,
              cancelTextColor: AppColor.typography,
            );

            return Future.value(false);
          },
          child: controller.Screen[controller.currentpage.value],
        ),
      ),
    );
  }
}
