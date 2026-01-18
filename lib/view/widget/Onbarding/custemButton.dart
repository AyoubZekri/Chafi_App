import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Onbarding_controller.dart';
import '../../../core/constant/Colorapp.dart';

class McustemButtonOnbarding extends GetView<OnbardingControllerImp> {
  const McustemButtonOnbarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnbardingControllerImp>(
      builder: (_) {
        return Container(
          height: 55,
          width: 250,
          decoration: BoxDecoration(
            color: AppColor.typography,
            borderRadius: BorderRadius.circular(15),
          ),
          child: MaterialButton(
            onPressed: () {
              controller.next();
            },

            child: Text(
              controller.currenpage == 2 ? "1".tr : "2".tr,
              style: context.textTheme.headlineMedium,
            ),
          ),
        );
      },
    );
  }
}
