import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/AppSestemTax/CategoriesAppController.dart';
import '../../../controller/Institutions/ChildCategoriesController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardCat.dart';

class Childcategories extends StatefulWidget {
  const Childcategories({super.key});

  @override
  State<Childcategories> createState() => _ChildcategoriesState();
}

class _ChildcategoriesState extends State<Childcategories> {
  final controller = Get.put(Childcategoriescontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("25".tr)),
      body: GetBuilder<Childcategoriescontroller>(
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
                          controller.gotoInfo(controller.data[i].id);
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
