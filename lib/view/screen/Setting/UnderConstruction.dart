import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/Colorapp.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    String title = Get.arguments?['title'] ?? 'قيد الإنجاز'.tr;

    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0, centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.engineering_outlined,
              size: 100,
              color: AppColor.primarycolor.withOpacity(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              "under_construction".tr,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.typography,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "under_construction_desc".tr,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
