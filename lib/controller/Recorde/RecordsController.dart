import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/datasource/Remote/MyPathData.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/model/MypathModel.dart';

abstract class Recordscontroller extends GetxController {
  void gotoInfoRecord(int id) {}
}

class RecordscontrollerImp extends Recordscontroller {
  Myservices myServices = Get.find();
  Rx<Statusrequest> statusrequest = Statusrequest.none.obs;
  Mypathdata categorydata = Mypathdata(Get.find());

  RxList<MypathModel> data = <MypathModel>[].obs;

  Future<void> viewdata() async {
    statusrequest.value = Statusrequest.loadeng;

    var response = await categorydata.viewdata({});
    print("Response: $response");

    statusrequest.value = handlingData(response);

    if (statusrequest.value == Statusrequest.success) {
      if (response["status"] == 1) {
        List listdata = response['data'];
        data.value = listdata.map((e) => MypathModel.fromJson(e)).toList();
        if (data.isEmpty) {
          statusrequest.value = Statusrequest.failure;
        }
      } else {
        statusrequest.value = Statusrequest.failure;
      }
    }
  }

  @override
  gotoInfoRecord(int id) {
    Get.toNamed(Approutes.inforecord, arguments: {"id": id});
  }

  gotoMypath() {
    Get.toNamed(Approutes.persontype);
  }



  @override
  void onInit() {
    viewdata();
    super.onInit();
  }
}
