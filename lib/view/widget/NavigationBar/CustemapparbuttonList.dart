import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/NavigationBarcontroller.dart';
import '../../../core/constant/Colorapp.dart';
import 'CustemApparButton.dart';

class CustemapparbuttonList extends StatelessWidget {
  const CustemapparbuttonList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationBarcontrollerImp>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // لون الظل
              blurRadius: 10, // مدى التمويه
              offset: const Offset(0, -4), // اتجاه الظل (سالب يعني للأعلى)
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: AppColor.white,
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(controller.Screen.length, ((i) {
                  return Custemapparbutton(
                    onPressed: () {
                      controller.ChangePage(i);
                    },
                    icondata: controller.IconsScreen[i]["icon"],
                    textButton: controller.Text[i]["Text"],
                    active: controller.currentpage == i,
                  );
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
