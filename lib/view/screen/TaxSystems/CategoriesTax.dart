import 'package:chafi/controller/Taxsystemstype/Categoriestaxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/handlingview.dart';
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
          return Handlingview(
            statusrequest: controller.statusrequest,
            widget: Container(
              padding: EdgeInsets.all(15),
              child: ListView(
                children: [
                  Text(
                    "select_category_hint".tr,
                    style: Get.textTheme.headlineSmall?.copyWith(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: controller.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Custemcardcat(
                        onTap: () {
                          controller.gotoInfo(controller.data[i].id);
                        },
                        body: controller.data[i].localizedName,
                        color1: Color(0xff4F46E5),
                        color2: Color(0xff8B5CF6),
                        sizeText: 24,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
