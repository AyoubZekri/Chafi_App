import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/NavigationBarcontroller.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/NavigationBar/CustemapparbuttonList.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    Get.put(NavigationBarcontrollerImp());
    return GetBuilder<NavigationBarcontrollerImp>(
        builder: (controller) => Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: const CustemapparbuttonList(),
              // ignore: deprecated_member_use
              body: WillPopScope(
                child: controller.Screen.elementAt(controller.currentpage),
                onWillPop: () {
                  Get.defaultDialog(
                    backgroundColor: AppColor.white,
                    title: "Alert".tr,
                    titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.black),
                    middleText: "هل تريد الخروج من التطبيق".tr,
                    onConfirm: () {
                      exit(0);
                    },
                    onCancel: () {
                      Get.back();
                    },
                    buttonColor: AppColor.primarycolor,
                    confirmTextColor: AppColor.white,
                    cancelTextColor: AppColor.primarycolor,
                  );

                  return Future.value(false);
                },
              ),
            ));
  }
}
