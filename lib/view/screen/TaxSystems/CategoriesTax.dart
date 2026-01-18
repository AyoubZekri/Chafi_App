import 'package:chafi/controller/Taxsystemstype/Categoriestaxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardCat.dart';

class Categoriestax extends StatefulWidget {
  const Categoriestax({super.key});

  @override
  State<Categoriestax> createState() => _CategoriestaxState();
}

class _CategoriestaxState extends State<Categoriestax> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Categoriestaxcontroller());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("${controller.nameappar}".tr)),
      body: GetBuilder<Categoriestaxcontroller>(
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
                      color2: Color(0xFF7333BD),
                      color1: Color(0xff270C46),
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
