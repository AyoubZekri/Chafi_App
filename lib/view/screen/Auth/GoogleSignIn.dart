import 'package:chafi/controller/Auth/GoogleSignInController.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/class/Statusrequest.dart';
import '../../../core/constant/imageassets.DART';
import '../../widget/Button/ButtonPrimary.dart';
import '../../widget/Button/CustemButtonSignin.dart';
import '../../widget/Text/CustemTextBodyLarge.dart';
import '../../widget/Text/CustemtextbodySmall.dart';

class Googlesignin extends StatefulWidget {
  const Googlesignin({super.key});

  @override
  State<Googlesignin> createState() => _GooglesigninState();
}

class _GooglesigninState extends State<Googlesignin> {
  @override
  Widget build(BuildContext context) {
    Get.put(GooglesignincontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<GooglesignincontrollerImp>(
        builder: (controller) {
          return Container(
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: Get.locale == Locale("ar") ? 350 : null,
                  right: Get.locale == Locale("ar") ? null : 350,
                  child: Container(
                    width: Get.width - 40,
                    height: Get.height - 100,
                    decoration: BoxDecoration(
                      color: AppColor.typography,
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: Get.locale == Locale("ar") ? 20 : 60,
                    right: Get.locale == Locale("ar") ? 60 : 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 130),
                      Center(
                        child: Image.asset(Appimageassets.logo, height: 180),
                      ),
                      SizedBox(height: 40),
                      Custemtextbodylarge(content: "10".tr),
                      SizedBox(height: 30),
                      Custemtextbodysmall(content: "11".tr),
                      SizedBox(height: 30),
                      controller.statusrequest == Statusrequest.loadeng
                          ? Padding(
                              padding: const EdgeInsets.all(17.5),
                              child: const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColor.typography,
                                ),
                              ),
                            )
                          : Custembuttonsignin(
                              onTap: () {
                                controller.signInWithGoogle();
                              },
                              contentText: "12".tr,
                              contentImage: Appimageassets.google,
                            ),
                      SizedBox(height: 30),
                      Custembuttonprimary(
                        content: "13".tr,
                        onPressed: () {
                          controller.gotonavBar();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
