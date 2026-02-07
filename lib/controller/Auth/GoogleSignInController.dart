import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Logingoogle.dart';

class Googlesignincontroller extends GetxController {
  void gotoInfoUser(String uid) {}
  void gotoNavigationBar(String token, String uid) {}
  void signInWithGoogle() {}
}

class GooglesignincontrollerImp extends Googlesignincontroller {
  final LoginGoogle loginGoogle = LoginGoogle();
  LoginData loginData = LoginData(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  @override
  void signInWithGoogle() async {
    statusrequest = Statusrequest.loadeng;
    update();
    try {
      UserCredential userCredential = await loginGoogle.signInWithGoogle();
      final user = userCredential.user;
      if (user == null) {
        Get.snackbar("خطأ", "فشل تسجيل الدخول بواسطة Google");
        statusrequest = Statusrequest.none;
        return;
      }
      Login(user.uid);
    } catch (e) {
      print("Google SignIn Error: $e");
      statusrequest = Statusrequest.none;
      update();
      Get.snackbar("خطأ", e.toString());
    }
  }

  void Login(String? uid) async {
    statusrequest = Statusrequest.loadeng;
    update();
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $fcmToken");

      var response = await loginData.login({
        "uid": uid,
        "token": fcmToken,
      });

      print("Login Response: $response");

      if (response["status"] == 1) {
        myServices.sharedPreferences!.setString(
          "email",
          response["user"]["email"],
        );
        myServices.sharedPreferences!.setString(
          "username",
          response["user"]["username"],
        );
        myServices.sharedPreferences!.setString(
          "wilaya",
          response["user"]["wilaya"],
        );
        myServices.sharedPreferences!.setString(
          "numperPhone",
          response["user"]["numperPhone"],
        );
        myServices.sharedPreferences!.setInt("user_notify_status", 1);
        myServices.sharedPreferences!.setString(
          "token",
          response["access_token"],
        );
        statusrequest = Statusrequest.success;
        Get.offNamed(Approutes.navigationBar, arguments: {"uid": uid});
      } else {
        Get.offNamed(Approutes.infouser, arguments: {"uid": uid});
      }
    } catch (e) {
      print("Google SignIn Error: $e");
      Get.snackbar("خطأ", e.toString());
    }
  }

  void gotonavBar() {
    Get.toNamed(Approutes.navigationBar);
  }
}
