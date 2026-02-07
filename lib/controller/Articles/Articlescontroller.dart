import 'package:chafi/core/constant/routes.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../data/model/PostModel.dart';

abstract class Articlescontroller extends GetxController {
  void gotoditailsarticles(int id) {}
}

class ArticlescontrollerImp extends Articlescontroller {
  Postdata postdata = Postdata(Get.find());

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  List<PostModel> datapost = [];

  Future<void> viewpost() async {
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": 1};

    var response = await postdata.viewdata(dat);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        datapost.clear();
        List listdata = response['data'];
        datapost.addAll(listdata.map((e) => PostModel.fromJson(e)));
        datapost = List.from(datapost);
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
  gotoditailsarticles(int id) {
    Get.toNamed(Approutes.ditailsarticles, arguments: {"id": id});
  }

  @override
  void onInit() {
    viewpost();
    super.onInit();
  }
}
