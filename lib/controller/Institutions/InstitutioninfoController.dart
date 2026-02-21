import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
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
    if (!await checkInternet()) {
      statusrequest = Statusrequest.serverfailure;
      update();
      return;
    }
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"scope": type};

    var response = await institutionData.viewdata(dat);
    print("Response: $response");
    if (response == Statusrequest.serverfailure) {
      statusrequest = Statusrequest.serverfailure;
    }
    statusrequest = handlingData(response);

    if (response.containsKey("data") && response["data"] is List) {
      data.clear();
      List listdata = response['data'];
      print('==============$data');
      data.addAll(listdata.map((e) => dataModel.fromJson(e)));
      data = List.from(data);
      if (data.isEmpty) {
        statusrequest = Statusrequest.failure;
      }
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  Future<void> isReadeinstitution(int id) async {
    var response = await institutionData.isRead(id);
    print("===================$response");
    if (response["status"] == 1) {
      markAsReadLocal(id);
    }

    update();
  }

  Future<void> isReadeTax(int id) async {
    var response = await taxandappdata.isRead(id);
    print("===================$response");
    if (response["status"] == 1) {
      markAsReadLocal(id);
    }

    update();
  }

  Future<void> viewdataTax() async {
    if (!await checkInternet()) {
      statusrequest = Statusrequest.serverfailure;
      update();
      return;
    }
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
    if (!await checkInternet()) {
      statusrequest = Statusrequest.serverfailure;
      update();
      return;
    }
    statusrequest = Statusrequest.loadeng;
    update();
    final dat = {"type": typedeff};

    var response = await differentdata.viewdata(dat);
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response.containsKey("data") && response["data"] is List) {
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

  Future<void> isReadeDifferent(int id) async {
    var response = await differentdata.isRead(id);
    print("===================$response");
    if (response["status"] == 1) {
      markAsReadLocal(id);
    }

    update();
  }

  void markAsReadLocal(int id) {
    int index = data.indexWhere((e) => e.id == id);
    if (index != -1 && data[index].isread == false) {
      data[index].isread = true;
      data = List.from(data);
      update();
    }
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
