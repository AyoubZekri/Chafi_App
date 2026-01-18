import 'package:chafi/core/constant/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/datasource/Remote/Logingoogle.dart';

class Googlesignincontroller extends GetxController {
  void gotoInfoUser() {}
  void gotoNavigationBar() {}
  void signInWithGoogle() {}
}

class GooglesignincontrollerImp extends Googlesignincontroller {
  final LoginGoogle loginGoogle = LoginGoogle();
  @override
  void signInWithGoogle() async {
    try {
      UserCredential userCredential = await loginGoogle.signInWithGoogle();

      if (userCredential.user != null) {
        gotoInfoUser();
      }
    } catch (e) {
      print("$e");
      Get.snackbar("خطأ", e.toString());
    } finally {}
  }

  @override
  void gotoInfoUser() {
    Get.offNamed(Approutes.infouser);
  }

  @override
  void gotoNavigationBar() {
    Get.offAllNamed(Approutes.navigationBar);
  }
}
