
import 'package:get/get.dart';

import '../core/class/Statusrequest.dart';
import '../core/functions/handlingdatacontroller.dart';
import '../core/services/Services.dart';
import '../data/datasource/Remote/LawData.dart';
import '../data/model/LawModel.dart';

class Lawcontroller extends GetxController {
  Lawdata lawdata = Lawdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  List<LawModel> data = [];


  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await lawdata.viewdata();
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => LawModel.fromJson(e)));
        data = List.from(data);
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
    viewdata();
    super.onInit();
  }
}
