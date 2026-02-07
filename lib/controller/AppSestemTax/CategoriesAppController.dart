import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Categorydata.dart';
import '../../data/model/CategoryModel.dart';

class Categoriesappcontroller extends GetxController {
  int? nameappar;
  int? taxid;

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  Categorydata categorydata = Categorydata(Get.find());

  List<CategoryModel> data = [];

  // عرض البيانات
  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    final actData = {"type_cat": 2, "tax_id": taxid};

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
          statusrequest = Statusrequest.failure;
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
      arguments: {"name": nameappar, "type": 9,"cat_id":id},
    );
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    nameappar = args["name"];
    taxid = args["tax_id"];
    viewdata();
    super.onInit();
  }
}
