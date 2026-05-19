import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/AppSestemTax/CategoriesAppController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardCat.dart';

class Categoriesapp extends StatefulWidget {
  const Categoriesapp({super.key});

  @override
  State<Categoriesapp> createState() => _CategoriesappState();
}

class _CategoriesappState extends State<Categoriesapp> {
  final controller = Get.put(Categoriesappcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("29".tr)),
      body: GetBuilder<Categoriesappcontroller>(
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
                        color1: const Color(0xff4F46E5),
                        color2: const Color(0xff8B5CF6),
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
