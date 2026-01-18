import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Onbarding_controller.dart';
import '../../../core/constant/Colorapp.dart';

class McustemButtonOnbardingBack extends StatelessWidget {
  const McustemButtonOnbardingBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnbardingControllerImp>(
      builder: (controller) {
        if (controller.currenpage == 0) {
          return const SizedBox();
        }

        return Container(
          height: 55,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: MaterialButton(
            onPressed: controller.Back,
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 3),
            child: Text(
              "3".tr,
              style: context.textTheme.headlineMedium?.copyWith(
                color: AppColor.brand,
              ),
            ),
          ),
        );
      },
    );
  }
}
