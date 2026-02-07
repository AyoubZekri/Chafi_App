import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/NotificationData.dart';
import '../../data/model/NotificationModel.dart';

class Notificationcontroller extends GetxController {
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Notificationdata notificationdata = Notificationdata(Get.find());

  List<NotificationModel> data = [];

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await notificationdata.viewdata({});
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => NotificationModel.fromJson(e)));
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

  Future<void> deletdata(int id) async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await notificationdata.deletedata({"id": id.toString()});
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success && response["status"] == 1) {
      data.removeWhere((element) => element.id == id);
      update();
    }
  }

  Future<void> isRead(int id) async {
    final index = data.indexWhere((n) => n.id == id);
    if (index != -1 && data[index].isread == 0) {
      data[index].isread = 1;
      data = List.from(data);
      update();
    }
    await notificationdata.isReaddata({"id": id});
    update();
  }

  @override
  void onInit() {
    viewdata();
    super.onInit();
  }
}
