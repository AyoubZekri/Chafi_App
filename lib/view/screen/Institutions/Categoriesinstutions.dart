import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Institutions/CategoriesInstiutionsController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardCat.dart';

class Categoriesinstutions extends StatefulWidget {
  const Categoriesinstutions({super.key});

  @override
  State<Categoriesinstutions> createState() => _CategoriesinstutionsState();
}

class _CategoriesinstutionsState extends State<Categoriesinstutions> {
  final controller = Get.put(Categoriesinstitutionscontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("25".tr)),
      body: GetBuilder<Categoriesinstitutionscontroller>(
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
                    // Text(
                    //   "select_category_hint".tr,
                    //   style: Get.textTheme.headlineSmall?.copyWith(
                    //     fontSize: 18,
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    ...List.generate(controller.data.length, (i) {
                      return Custemcardcat(
                        onTap: () {
                          controller.gotoChildCategory(controller.data[i].id);
                        },
                        body: controller.data[i].localizedName,
                        color1: Color(0xff164573),
                        color2: Color(0xff164573),
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
