import 'package:chafi/core/constant/routes.dart';
import 'package:get/get.dart';

class Infousercontroller extends GetxController {
  gotoNavigationBar() {}
}

class InfousercontrollerImp extends Infousercontroller {
  bool isSwitched = false;
  @override
  gotoNavigationBar() {
    Get.offAllNamed(Approutes.navigationBar);
  }
}
