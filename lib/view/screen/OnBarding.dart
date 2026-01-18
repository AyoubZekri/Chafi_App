import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../controller/Onbarding_controller.dart';
import '../widget/Onbarding/DOTcontroller.dart';
import '../widget/Onbarding/custemButton.dart';
import '../widget/Onbarding/custemButtonBack.dart';
import '../widget/Onbarding/custemSlider.dart';

class OnBarding extends StatefulWidget {
  const OnBarding({super.key});

  @override
  State<OnBarding> createState() => _OnBardingState();
}

class _OnBardingState extends State<OnBarding> {
  @override
  Widget build(BuildContext context) {
    Get.put(OnbardingControllerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: const [
                CUstemSliderOnbarding(),
                
                CustemDotControllerOnbarding(),
              ],
            ),

            Positioned(
              bottom: 230,
              left: Get.locale == Locale("ar") ? 20 : null,
              right: Get.locale == Locale("ar") ? null : 20,
              child: McustemButtonOnbarding(),
            ),
            Positioned(
              bottom: 150,
              left: Get.locale == Locale("ar") ? 20 : null,
              right: Get.locale == Locale("ar") ? null : 20,

              child: McustemButtonOnbardingBack(),
            ),

            Positioned(
              bottom: -150,
              left: Get.locale == Locale("ar") ? 300 : null,
              right: Get.locale == Locale("ar") ? null : 300,

              child: Container(
                width: 484,
                height: 484,
                decoration: BoxDecoration(
                  color: AppColor.typography,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
