import 'dart:io';
import 'package:get/get.dart';

import '../../core/functions/uploudfiler.dart';

class Editprofailecontroller extends GetxController {
  Future<void> uploadimagefile() async {}
}

class EditprofailecontrollerImp extends Editprofailecontroller {
  File? file;
  @override
  Future<void> uploadimagefile() async {
    file = await fileuploadGallery(false);
    update();
  }
}
