import 'package:get/get.dart';

import '../../core/constant/routes.dart';

class Categoriestaxcontroller extends GetxController {
  late final int nameappar;
  gotoInfo() {
    Get.toNamed(
      Approutes.institutionsinfo,
      arguments: {"name": nameappar, "type": 8},
    );
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    nameappar = args["name"];
    super.onInit();
  }
}
