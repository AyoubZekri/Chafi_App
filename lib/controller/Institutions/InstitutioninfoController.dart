import 'package:get/get.dart';

abstract class Institutioninfocontroller extends GetxController {}

class InstitutioninfocontrollerImp extends Institutioninfocontroller {
  late final int nameappar;
  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    nameappar = args["name"];
    super.onInit();
  }
}
