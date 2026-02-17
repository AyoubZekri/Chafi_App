import 'package:chafi/controller/HomeController.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Imageassets.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomecontrollerImp>();
    return GetBuilder<HomecontrollerImp>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: controller.image != null && controller.isLoggedIn == true
                  ? ClipOval(
                      child: Image.file(
                        controller.image!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      Appimageassets.avater,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
            ),

            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'hello'.tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF566573),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'slogan'.tr,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: Color(0xFF1C2833),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Approutes.notification);
              },
              child: Icon(
                Icons.notifications,
                size: 45,
                color: Color(0xFF154360),
              ),
            ),
            SizedBox(width: 10),
          ],
        );
      },
    );
  }
}
