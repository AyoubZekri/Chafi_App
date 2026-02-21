import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/Statusrequest.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/Services.dart';
import '../data/datasource/Remote/AppointmentscommitmentsData.dart';
import '../data/model/AppointmentsModel.dart';

class AppointmentscommitmentscontrollerImp extends GetxController {
  int? taxid;

  Appointmentscommitmentsdata lawdata = Appointmentscommitmentsdata(Get.find());
  Myservices myServices = Get.find();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  Statusrequest statusrequest = Statusrequest.none;
  List<Appointmentsmodel> data = [];

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    final requst = {"tax_id": taxid};

    var response = await lawdata.viewdata(requst);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => Appointmentsmodel.fromJson(e)));
        if (data.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    taxid = args["tax_id"] ?? 0;
    print("=============$taxid");
    viewdata();
    super.onInit();
  }
}
