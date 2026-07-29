import 'package:chafi/view/screen/Calculators/different/TouristVehicles/TouristCehiclesCost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/constant/Colorapp.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../core/functions/Snacpar.dart';
import '../../view/screen/Calculators/different/TouristVehicles/ShwototalTouristVehicles.dart';
import 'Costsguidancecontroller.dart';

class Touristcehiclescontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;
  int type = 0;
  int isMainRenting = 0;

  TextEditingController nameguidance = TextEditingController();
  TextEditingController costsguidance = TextEditingController();
  TextEditingController countguidance = TextEditingController();

  List<GiftModel> gifts = [];

  double total = 0;
  double addreselttax = 0;
  double netTax = 0;

  void selectedPerson(int i) {
    type = i;
    update();
  }

  void selectedMainRenting(int i) {
    isMainRenting = i;
    update();
  }

  void goToNextFromInitial() {
    if (isMainRenting == 0) {
      return showSnackbar("خطأ".tr, "يرجى الإجابة على السؤال".tr, Colors.red);
    }
    if (isMainRenting == 1) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.primarycolor.withOpacity(0.08),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.primarycolor.withOpacity(0.15),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    color: AppColor.primarycolor,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "ملاحظة".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColor.typography,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "مسموح خصم جميع المصاريف".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.typography,
                    foregroundColor: AppColor.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "موافق".tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      Get.toNamed('/Toueisttype');
    }
  }

  void gotodatacreate() {
    if (type == 0) {
      return showSnackbar("خطأ".tr, "إختر نوع الحساب".tr, Colors.red);
    }
    Get.to(Touristcehiclescost());
  }

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
      return showSnackbar("خطأ".tr, "لا يوجد مركبات".tr, Colors.red);
    }
    total = 0;
    addreselttax = 0;
    netTax = 0;

    double sumTD = 0;
    double sumTND = 0;

    for (var gift in gifts) {
      int cost = gift.cost;
      int q = gift.quantity;

      if (type == 2) {
        // كراء: no per unit limit
        double itemTotal = (cost * q).toDouble();
        sumTD += itemTotal;
        netTax += itemTotal;
      } else {
        // صيانة: max 2,000,000 per unit
        int unitDeductible = cost > 2000000 ? 2000000 : cost;
        int unitNonDeductible = cost > 2000000 ? cost - 2000000 : 0;

        sumTD += (unitDeductible * q).toDouble();
        sumTND += (unitNonDeductible * q).toDouble();
        netTax += (cost * q).toDouble();
      }
    }

    if (type == 2) {
      // كراء: global limit 20,000,000
      if (sumTD > 20000000) {
        double excess = sumTD - 20000000;
        total = 20000000;
        addreselttax = excess;
      } else {
        total = sumTD;
        addreselttax = 0;
      }
    } else {
      // صيانة: no global limit
      total = sumTD;
      addreselttax = sumTND;
    }

    update();
    Get.to(() => Shwototaltouristvehicles());
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
