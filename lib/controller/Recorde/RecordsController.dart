import 'package:chafi/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class Recordscontroller extends GetxController {
  void gotoInfoRecord() {}
}

class RecordscontrollerImp extends Recordscontroller {
  @override
  gotoInfoRecord() {
    Get.toNamed(Approutes.inforecord);
  }
}
