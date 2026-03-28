import 'package:chafi/data/datasource/Remote/MyPathData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import 'InforecordController.dart';

class Editrecordcontroller extends GetxController {
  int? id;
  int taxid = -1;
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Mypathdata mypathdata = Mypathdata(Get.find());

  void selectTaxsystemstype(int i) {
    taxid = i;
    update();
  }

  Future<void> ediddata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await mypathdata.editdata({"id": id, "tax_id": taxid});
    print("Response: $response");
    if (response == Statusrequest.serverfailure) {
      showSnackbar("خطأ".tr, "No Internet Connection".tr, Colors.red);
      statusrequest = Statusrequest.none;
      update();
      return;
    }
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        final infoController = Get.find<InforecordcontrollerImp>();

        infoController.data[0] = infoController.data[0].copyWith(
          taxId: taxid,
          updatedAt: DateTime.now(),
        );

        infoController.update();
        Get.back(result: true);
      } else {
        statusrequest = Statusrequest.failure;
      }
    } else {
      statusrequest = Statusrequest.none;
      showSnackbar("خطأ".tr, "حدث خطأ".tr, Colors.red);
    }

    update();
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    id = args["id"];
    super.onInit();
  }
}
