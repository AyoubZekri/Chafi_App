import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/view/widget/Card/CustemCardConferm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/InfoUserController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/TextFild/CustemTextFromFildInfoUser.dart';

class Infouser extends StatefulWidget {
  const Infouser({super.key});

  @override
  State<Infouser> createState() => _InfouserState();
}

class _InfouserState extends State<Infouser> {
  @override
  Widget build(BuildContext context) {
    Get.put(InfousercontrollerImp());
    return GetBuilder<InfousercontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Custemsuberbutton(
              content: "19".tr,
              color: AppColor.brand,
              onPressed: () {
              controller.gotoNavigationBar();
              },
            ),
          ),

          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 70),
                Text(
                  "14".tr,
                  style: context.textTheme.headlineSmall?.copyWith(
                    height: 1.5,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                CustemtextfromfildInfoUser(hintText: "15".tr, enabled: true),
                CustemtextfromfildInfoUser(hintText: "16".tr, enabled: true),
                CustemtextfromfildInfoUser(hintText: "17".tr, enabled: true),
                Custemcardconferm(
                  value: controller.isSwitched,
                  onChanged: (value) {
                    setState(() {
                      controller.isSwitched = value;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
