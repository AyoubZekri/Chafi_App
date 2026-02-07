import 'package:chafi/controller/Recorde/RecordsController.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/datasource/Remote/MyPathData.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/model/MypathModel.dart';

abstract class Inforecordcontroller extends GetxController {
  void gotoEditRecord() {}
}

class InforecordcontrollerImp extends Inforecordcontroller {
  int? id;
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Mypathdata categorydata = Mypathdata(Get.find());

  List<MypathModel> data = [];

  // عرض البيانات
  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await categorydata.viewdata({"id": id});
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data = MypathModel.fromJsonList(listdata);
        if (data.isEmpty) {
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  Future<void> daletedata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await categorydata.deletedata({"id": id});
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.removeWhere((element) => element.id == id);
        update();
        final recordsController = Get.find<RecordscontrollerImp>();
        recordsController.data.removeWhere((element) => element.id == id);
        Get.back();
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  @override
  void gotoEditRecord() {
    Get.toNamed(Approutes.editrecord, arguments: {"id": id});
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    id = args["id"];
    viewdata();
    super.onInit();
  }
}
