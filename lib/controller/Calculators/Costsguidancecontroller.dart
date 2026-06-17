import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../view/screen/Calculators/different/guidance/Shwototalguidance.dart';

class GiftModel {
  String name;
  int cost;
  int quantity;

  GiftModel({required this.name, required this.cost, required this.quantity});
}

class Costsguidancecontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;

  TextEditingController nameguidance = TextEditingController();
  TextEditingController costsguidance = TextEditingController();
  TextEditingController countguidance = TextEditingController();

  List<GiftModel> gifts = [];

  double total = 0;
  double addreselttax = 0;
  double netTax = 0;

  void addGuidance() {
    String name = nameguidance.text.trim();
    String costText = costsguidance.text.replaceAll(RegExp(r'[^0-9]'), '');
    String countText = countguidance.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (name.isEmpty || costText.isEmpty || countText.isEmpty) return;

    int cost = int.parse(costText);
    int count = int.parse(countText);

    gifts.add(GiftModel(name: name, cost: cost, quantity: count));

    nameguidance.clear();
    costsguidance.clear();
    countguidance.clear();

    update();
  }

  void calcul() {
    if (gifts.isEmpty) {
      return showSnackbar("خطأ".tr, "لا يوجد هدايا".tr, Colors.red);
    }
    total = 0;
    addreselttax = 0;
    netTax = 0; // مهم جدا

    double sumTD = 0;
    double sumTND = 0;

    for (var gift in gifts) {
      int cost = gift.cost;
      int q = gift.quantity;
      int unitDeductible = cost > 100000 ? 100000 : cost;
      int unitNonDeductible = cost > 100000 ? cost - 100000 : 0;

      double td = (unitDeductible * q).toDouble();
      double tnd = (unitNonDeductible * q).toDouble();

      sumTD += td;
      sumTND += tnd;
      netTax += (cost * q); // Total entered value
    }

    if (sumTD > 50000000) {
      double excess = sumTD - 50000000;
      total = 50000000;
      addreselttax = sumTND + excess;
    } else {
      total = sumTD;
      addreselttax = sumTND;
    }

    update();
    Get.to(() => Shwototalguidance());
  }

  void Back() {
    nameguidance.clear();
    costsguidance.clear();
    countguidance.clear();
    netTax = 0;
    gifts.clear();
    update();
    Get.back();
  }

  void BackfromShow() {
    nameguidance.clear();
    costsguidance.clear();
    countguidance.clear();
    netTax = 0;
    total = 0;
    addreselttax = 0;
    update();
    Get.back();
  }

  void resetAll() {
    nameguidance.clear();
    costsguidance.clear();
    countguidance.clear();
    netTax = 0;
    gifts.clear();
    update();
    Get.until((route) => Get.currentRoute == fromPage);
  }

  Future<void> addenter(int type_stats) async {
    update();
    if (!await checkInternet()) {
      print("=======checkInternet false=====${await checkInternet()}");
      return;
    }
    var response = await postdata.adddata({
      'device_id': myServices.sharedPreferences?.getString('device_id'),
      "type_stats": type_stats,
    });
    print("=======================$response");
    statusrequest = handlingData(response);
    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        print('==================enter+1');
        statusrequest = Statusrequest.success;
      }
    }
    update();
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    addenter(4);
    super.onInit();
  }
}
