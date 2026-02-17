import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/NavigationBarcontroller.dart';
import '../../../core/constant/Colorapp.dart';
import 'CustemApparButton.dart';

class CustemapparbuttonList extends StatelessWidget {
  const CustemapparbuttonList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationBarcontrollerImp>();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: AppColor.white,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(controller.Screen.length, (i) {
              return Custemapparbutton(
                onPressed: () => controller.ChangePage(i),
                icondata: controller.IconsScreen[i]["icon"],
                textButton: controller.texts[i]["Text"]!, // النصوص تتغير تلقائياً
                active: controller.currentpage.value == i,
              );
            }),
          );
        }),
      ),
    );
  }
}
