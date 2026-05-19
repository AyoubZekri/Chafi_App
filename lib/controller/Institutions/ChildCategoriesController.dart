import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Categorydata.dart';
import '../../data/model/CategoryModel.dart';

class Childcategoriescontroller extends GetxController {
  int catid = 0;
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Categorydata categorydata = Categorydata(Get.find());

  List<CategoryModel> data = [];

  // عرض البيانات
  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    final actData = {"type": 4, "cat_id": catid};

    var response = await categorydata.viewdata(actData);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => CategoryModel.fromJson(e)));
        data = List.from(data);
        if (data.isEmpty) {
          statusrequest = Statusrequest.nodata;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  gotoInfo(int id) {
    Get.toNamed(
      Approutes.institutionsinfo,
      arguments: {"name": 25, "type": 1, "cat_id": id},
    );
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    catid = args["cat_id"] ?? 0;
    viewdata();
    super.onInit();
  }

  Future<void> getData() async {
    viewdata();
  }
}
