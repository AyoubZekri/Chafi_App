import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../data/model/PostModel.dart';

class Ditailsarticlescontroller extends GetxController {
  int? id;
  Postdata postdata = Postdata(Get.find());

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  List<PostModel> datapost = [];

  // عرض البيانات
  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await postdata.viewdata({"id": id, "type": 1});
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        datapost.clear();
        List listdata = response['data'];
        datapost = PostModel.fromJsonList(listdata);
        if (datapost.isEmpty) {
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
    id = args["id"];
    viewdata();
    super.onInit();
  }
}
