import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/datasource/Remote/Logingoogle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/imageassets.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/Services.dart';
import '../view/widget/Setting/custemLanguge.dart';

class Profailecontroller extends GetxController {
  void gotoEditProfaile() {}
  void gotoNotification() {}
  void gotoContactus() {}
  void gotoInformationapp() {}
  void gotoPrivacypolicy() {}
  void gotoExternallinks() {}
}

class ProfailecontrollerImp extends Profailecontroller {
  LoginData loginData = LoginData(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  @override
  gotoEditProfaile() {
    Get.toNamed(Approutes.editprofaile);
  }

  @override
  gotoNotification() {
    Get.toNamed(Approutes.notification);
  }

  @override
  gotoContactus() {
    Get.toNamed(Approutes.contactus);
  }

  @override
  gotoInformationapp() {
    Get.toNamed(Approutes.informationapp);
  }

  @override
  gotoPrivacypolicy() {
    Get.toNamed(Approutes.privacypolicy);
  }

  @override
  gotoExternallinks() {
    Get.toNamed(Approutes.externallinks);
  }

  void showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Text(
                  "Langugs".tr,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: AppColor.black),
                ),
              ),
              const SizedBox(height: 10),
              Custemlanguge(
                Langugs: "ar",
                long: "Arabic".tr,
                image: Appimageassets.alg,
              ),
              const SizedBox(height: 10),
              Custemlanguge(
                Langugs: "fr",
                long: "France".tr,
                image: Appimageassets.fr,
              ),
            ],
          ),
        );
      },
    );
  }

  logout() async {
    Statusrequest statusrequest = Statusrequest.loadeng;
    update();
    var response = await loginData.logout();

    statusrequest = handlingData(response);
    print("=============================== Controller $response ");
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        myServices.sharedPreferences!.clear();
        myServices.sharedPreferences!.setBool("onbording", true);
        Get.offNamed(Approutes.googleSignIn);
      }
    } else {}
    update();
  }
}
