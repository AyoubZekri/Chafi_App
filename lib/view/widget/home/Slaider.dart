import 'package:chafi/controller/HomeController.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../Onbarding/DOT.dart';

class Slaider extends GetView<HomecontrollerImp> {
  const Slaider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.Onbardinslider,
              itemCount: controller.imgSlaider.length,
              itemBuilder: (context, i) {
                return Image.asset(
                  controller.imgSlaider[i]['Image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: (Get.width / 2) - ((controller.imgSlaider.length * 8) + 20),
          child: Dot(),
        ),
      ],
    );
  }
}
