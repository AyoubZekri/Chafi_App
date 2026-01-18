import 'package:get/get.dart';

import '../../core/constant/routes.dart';

class Categoriesappcontroller extends GetxController {
  gotoInfo() {
    Get.toNamed(Approutes.institutionsinfo, arguments: {"name": 29, "type": 13});
  }
}
