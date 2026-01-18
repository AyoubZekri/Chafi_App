import 'package:chafi/controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomecontrollerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            controller.imgSlaider.length,
            (i) => AnimatedContainer(
              margin: const EdgeInsets.only(right: 10),
              duration: const Duration(milliseconds: 900),
              width: controller.currenpage == i ? 15 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: controller.currenpage != i
                    ? Colors.grey[400]
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
