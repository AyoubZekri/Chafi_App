import 'package:chafi/controller/Recorde/RecordsController.dart';
import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/datasource/Remote/MyPathData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/constant/Colorapp.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/AppointmentscommitmentsData.dart';
import '../../data/model/AppointmentsModel.dart';
import '../../data/model/MypathModel.dart';

abstract class Inforecordcontroller extends GetxController {
  void gotoEditRecord(int activityTaxId);
  Future<void> refreshAll();
}

class InforecordcontrollerImp extends Inforecordcontroller {
  int? id;
  int? taxid;
  int? frompage;

  final Myservices myServices = Get.find();
  final Mypathdata categorydata = Mypathdata(Get.find());
  final Appointmentscommitmentsdata lawdata = Appointmentscommitmentsdata(
    Get.find(),
  );

  // Separate Status لكل جزء
  Statusrequest recordStatus = Statusrequest.none;
  Statusrequest appointmentStatus = Statusrequest.none;
  Statusrequest deleteStatus = Statusrequest.none;

  List<MypathModel> data = [];
  List<Appointmentsmodel> appointments = [];

  // ===============================
  // Fetch Record Details
  // ===============================
  Future<void> viewdata() async {
    recordStatus = Statusrequest.loadeng;
    update();

    var response = await categorydata.viewdata({"id": id});
    print("=====================$response");
    recordStatus = handlingData(response);

    if (recordStatus == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data = MypathModel.fromJsonList(listdata);

        if (data.isEmpty) {
          recordStatus = Statusrequest.nodata;
        }
      } else {
        recordStatus = Statusrequest.failure;
      }
    }

    update();
  }

  // ===============================
  // Fetch Appointments
  // ===============================
  Future<void> viewdataappointments() async {
    appointmentStatus = Statusrequest.loadeng;
    update();

    final request = {"tax_id": taxid};
    var response = await lawdata.viewdata(request);

    appointmentStatus = handlingData(response);

    if (appointmentStatus == Statusrequest.success) {
      if (response["status"] == 1) {
        appointments.clear();
        List listdata = response['data'];

        appointments.addAll(listdata.map((e) => Appointmentsmodel.fromJson(e)));

        if (appointments.isEmpty) {
          appointmentStatus = Statusrequest.nodata;
        }
      } else {
        appointmentStatus = Statusrequest.failure;
      }
    }

    update();
  }

  // ===============================
  // Delete Record
  // ===============================
  Future<void> daletedata() async {
    deleteStatus = Statusrequest.loadeng;
    update();

    var response = await categorydata.deletedata({"id": id});

    deleteStatus = handlingData(response);

    if (deleteStatus == Statusrequest.success) {
      if (response["status"] == 1) {
        // data.removeWhere((element) => element.id == id);

        final recordsController = Get.find<RecordscontrollerImp>();
        recordsController.data.removeWhere((element) => element.id == id);

        Get.back();
      } else {
        showSnackbar("خطأ".tr, "حدث خطأ".tr, Colors.red);
        deleteStatus = Statusrequest.failure;
      }
    } else {
      showSnackbar("خطأ".tr, "حدث خطأ".tr, Colors.red);
    }

    update();
  }

  // ===============================
  // Refresh All Data
  // ===============================
  @override
  Future<void> refreshAll() async {
    await Future.wait([viewdata(), viewdataappointments()]);
  }

  // ===============================
  // Navigation
  // ===============================

  @override
  Future<void> gotoEditRecord(int activityTaxId) async {
    final result = await Get.toNamed(
      Approutes.editrecord,
      arguments: {"id": id, "activityTaxId": activityTaxId},
    );

    if (result == true) {
      taxid = data[0].taxId;
      viewdataappointments();
      final recordsController = Get.find<RecordscontrollerImp>();
      await recordsController.viewdata();
    }
  }

  Future<void> updateTaxIdDirectly(int newTaxId) async {
    // Show loading overlay
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: AppColor.white)),
      barrierDismissible: false,
    );

    var response = await categorydata.editdata({"id": id, "tax_id": newTaxId});
    Get.back(); // close loading overlay

    if (response == Statusrequest.serverfailure) {
      showSnackbar("خطأ".tr, "لا يوجد اتصال بالانترنت".tr, Colors.red);
      return;
    }

    Statusrequest status = handlingData(response);
    if (status == Statusrequest.success && response["status"] == 1) {
      // Update local data
      data[0] = data[0].copyWith(taxId: newTaxId, updatedAt: DateTime.now());
      taxid = newTaxId;
      update();

      // Show success
      showSnackbar(
        "نجاح".tr,
        "تم تعديل النظام الجبائي بنجاح".tr,
        AppColor.brand,
      );

      // Refresh related data
      viewdataappointments();
      final recordsController = Get.find<RecordscontrollerImp>();
      await recordsController.viewdata();
    } else {
      showSnackbar("خطأ".tr, "حدث خطأ أثناء التعديل".tr, Colors.red);
    }
  }

  back() {
    if (frompage == 1) {
      Get.offAllNamed(Approutes.navigationBar);
    } else {
      Get.back();
    }
  }

  // ===============================
  // Init
  // ===============================
  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;

    id = args["id"];
    taxid = args["taxid"];
    frompage = args["type"];

    print("===================$taxid");
    refreshAll();

    super.onInit();
  }
}
