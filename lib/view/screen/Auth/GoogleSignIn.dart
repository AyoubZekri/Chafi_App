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
  void initState() {
    super.initState();
    if (!Get.isRegistered<GooglesignincontrollerImp>()) {
      Get.put(GooglesignincontrollerImp());
    }
  }

  Widget build(BuildContext context) {
    // Determine a safe offset for the side container
    final double sideOffset = Get.width * 0.85; // instead of hardcoded 350

    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<GooglesignincontrollerImp>(
        builder: (controller) {
          return Stack(
            children: [
              Positioned(
                top: 50,
                bottom: 50, // use bottom instead of fixed height
                left: Get.locale == Locale("ar") ? sideOffset : null,
                right: Get.locale == Locale("ar") ? null : sideOffset,
                child: Container(
                  width: Get.width - 40,
                  decoration: BoxDecoration(
                    color: AppColor.typography,
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: Get.locale == Locale("ar") ? 20 : 60,
                      right: Get.locale == Locale("ar") ? 60 : 20,
                      top: 40,
                      bottom: 40,
                    ),
                    // Constrain the minimum height so the content is centered if possible
                    constraints: BoxConstraints(
                      minHeight: Get.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(Appimageassets.logo, height: Get.height * 0.2), // Responsive image height
                          ),
                          SizedBox(height: 40),
                          Custemtextbodylarge(content: "10".tr),
                          SizedBox(height: 30),
                          Custemtextbodysmall(content: "11".tr),
                          SizedBox(height: 30),
                          controller.statusrequest == Statusrequest.loadeng
                              ? Custembuttonsignin(
                                  contentText: "12".tr,
                                  contentImage: Appimageassets.google,
                                  laoding: true,
                                )
                              : Custembuttonsignin(
                                  onTap: () {
                                    controller.signInWithGoogle();
                                  },
                                  contentText: "12".tr,
                                  contentImage: Appimageassets.google,
                                  laoding: false,
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
