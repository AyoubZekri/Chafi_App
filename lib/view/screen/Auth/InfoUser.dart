import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/view/widget/Card/CustemCardConferm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/InfoUserController.dart';
import '../../../core/class/Statusrequest.dart';
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
            child: controller.statusrequest == Statusrequest.loadeng
                ? Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.brand,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child:  SizedBox(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Custemsuberbutton(
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
                CustemtextfromfildInfoUser(
                  myController: controller.username,
                  hintText: "15".tr,
                  enabled: true,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.wilaya,
                  hintText: "16".tr,
                  enabled: true,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.numperPhone,
                  hintText: "17".tr,
                  enabled: true,
                ),
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
