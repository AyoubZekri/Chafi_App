import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Different/CategoriesAppController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardCat.dart';

class CategoriesDiff extends StatefulWidget {
  const CategoriesDiff({super.key});

  @override
  State<CategoriesDiff> createState() => _CategoriesDiffState();
}

class _CategoriesDiffState extends State<CategoriesDiff> {
  final controller = Get.put(CategoriesDiffcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("30".tr)),
      body: GetBuilder<CategoriesDiffcontroller>(
        builder: (controller) {
          return RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData();
            },
            child: Handlingview(
              statusrequest: controller.statusrequest,
              widget: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "select_category_hint".tr,
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ...List.generate(controller.data.length, (i) {
                      return Custemcardcat(
                        onTap: () {
                          controller.gotoInfo(controller.data[i].id);
                        },
                        body: controller.data[i].localizedName,
                        color1: const Color(0xFF0EA5E9), // Sky
                        color2: const Color(0xFF0369A1),
                        sizeText: 24,
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
