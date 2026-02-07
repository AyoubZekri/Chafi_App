import 'package:chafi/data/model/InstitutionModel.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Differentdata.dart';

class Externallinkscontroller extends GetxController {
  Differentdata differentdata = Differentdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  List<dataModel> data = [];

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": 2};

    var response = await differentdata.viewdata(dat);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => dataModel.fromJson(e)));
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

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    viewdata();
    super.onInit();
  }
}
