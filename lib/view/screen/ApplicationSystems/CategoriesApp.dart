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
  @override
  Widget build(BuildContext context) {
    Get.put(Categoriesappcontroller());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("29".tr)),
      body: GetBuilder<Categoriesappcontroller>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Text(
                "select_category_hint".tr,
                  style: Get.textTheme.headlineSmall?.copyWith(fontSize: 18),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Custemcardcat(
                      onTap: () {
                        controller.gotoInfo();
                      },
                      body: "المخالفات",
                      color1: Color(0xff4F46E5),
                      color2: Color(0xff8B5CF6),
                      sizeText: 24,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
