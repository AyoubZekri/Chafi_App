import 'package:chafi/controller/HomeController.dart';
import 'package:get/get.dart';

import '../controller/Auth/GoogleSignInController.dart';
import '../core/class/Crud.dart';
import '../core/services/Services.dart';

class Initialbindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(Myservices());
    Get.put(HomecontrollerImp(), permanent: true);
  }
}

// class HomeBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<HomecontrollerImp>(() => HomecontrollerImp());
//   }
// }

// class GoogleSigninBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(GooglesignincontrollerImp());
//   }
// }
