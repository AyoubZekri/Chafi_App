import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/Onbarding_controller.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';

class CUstemSliderOnbarding extends GetView<OnbardingControllerImp> {
  const CUstemSliderOnbarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 510,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (val) {
          controller.Onbardinslider(val);
        },
        itemCount: onBardinglist.length,
        itemBuilder: (context, i) => Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              onBardinglist[i].image!,
              width: 290,
              height: 339,
              fit: BoxFit.fill,
            ),
            Text(
              onBardinglist[i].title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColor.grey,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: Get.width - 100,
              alignment: Alignment.center,
              child: Text(
                onBardinglist[i].body!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  color: AppColor.brand,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
