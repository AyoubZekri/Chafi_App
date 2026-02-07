import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/Differentdata.dart';
import '../../data/datasource/Remote/TaxAndAppData.dart';
import '../../data/datasource/Remote/institution.dart';
import '../../data/model/InstitutionModel.dart';

abstract class Institutioninfocontroller extends GetxController {}

class InstitutioninfocontrollerImp extends Institutioninfocontroller {
  late final int nameappar;
  int? type;
  int? catid;
  int? typedeff;

  InstitutionData institutionData = InstitutionData(Get.find());
  Taxandappdata taxandappdata = Taxandappdata(Get.find());
  Differentdata differentdata = Differentdata(Get.find());

  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;

  List<dataModel> data = [];

  Future<void> viewdata() async {
    print("=======================institution");

    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"scope": type};

    var response = await institutionData.viewdata(dat);
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

  Future<void> viewdataTax() async {
    print("=======================TaxandApp");
    print("=======================$catid");

    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"cat_id": catid};

    var response = await taxandappdata.viewdata(dat);
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

  Future<void> viewdataDifferent() async {
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": typedeff};

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

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    nameappar = args["name"];
    type = args["type"];
    catid = args["cat_id"] ?? 0;
    typedeff = args["type_deff"] ?? 0;

    (type == 8 || type == 9)
        ? viewdataTax()
        : type == 10
        ? viewdataDifferent()
        : viewdata();
    super.onInit();
  }
}
