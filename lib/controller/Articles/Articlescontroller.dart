import 'package:chafi/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class Articlescontroller extends GetxController {
  void gotoditailsarticles() {}
}

class ArticlescontrollerImp extends Articlescontroller {
  @override
  gotoditailsarticles() {
    Get.toNamed(Approutes.ditailsarticles);
  }
}
