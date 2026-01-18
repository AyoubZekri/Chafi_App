import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/Onbarding_controller.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';

class CustemDotControllerOnbarding extends StatelessWidget {
  const CustemDotControllerOnbarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnbardingControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            onBardinglist.length,
            (i) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 10),
              duration: const Duration(milliseconds: 900),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: controller.currenpage == i
                    ? AppColor.brand
                    : Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
