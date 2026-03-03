import 'package:chafi/view/screen/Calculators/different/TouristVehicles/TouristCehiclesCost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/Snacpar.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/FinalSubjugation.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/IncomeValue.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/PropertyType.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/TypeOfCollection.dart';

class Realestateincomecontroller extends GetxController {
  String? fromPage;
  int typeOvercome = 0; //YES 1 NO 2
  int typePropertytype = 0; //YES 1 NO 2
  int typeTypeofcollection = 0; // 1monthly 2tripartite 3six 4annual 5no

  String? incmevalueErorr;
  String? dataTheContractErorr;
  // String? datacollectionErorr;
  String? datapaymentErorr;
  TextEditingController incmevalue = TextEditingController();
  TextEditingController dataTheContract = TextEditingController();
  // TextEditingController datacollection = TextEditingController();
  TextEditingController datapayment = TextEditingController();

  double netTax = 0;
  double Penalty = 0;
  double tax = 0;
  double incmevalues = 0;
  double total = 0;
  double discout = 0;

  void selectedOvercome(int i) {
    typeOvercome = i;
    update();
  }

  void gotoPropertytype() {
    if (typeOvercome == 0) {
      return showSnackbar(
        "خطأ".tr,
        "يرجى اختيار نعم أو لا بخصوص التجاوز.".tr,
        Colors.red,
      );
    }
    Get.to(Propertytype());
  }

  void selectedPropertytype(int i) {
    typePropertytype = i;
    update();
  }

  void gotoTypeofcollection() {
    if (typeOvercome == 0) {
      return showSnackbar("خطأ".tr, "يرجى اختيار نوع العقار.".tr, Colors.red);
    }
    Get.to(Typeofcollection());
  }

  void selectedTypeofcollection(int i) {
    typeTypeofcollection = i;
    update();
  }

  void gotodataIncomevalue() {
    if (typeOvercome == 0) {
      return showSnackbar("خطأ".tr, "يرجى اختيار نوع التحصيل.".tr, Colors.red);
    }
    Get.to(Incomevalue());
  }

  void calcul() {
    bool hasError = validateAllFields();
    incmevalues =
        double.tryParse(incmevalue.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final dateContract = parseDate(dataTheContract.text);
    // final datacollections = parseDate(datacollection.text);
    final datapayments = parseDate(datapayment.text);

    if (!hasError) {
      if (typeOvercome == 2) {
        if (typePropertytype == 1) {
          netTax = incmevalues * 0.07;
        } else if ((typePropertytype == 2 || typePropertytype == 3)) {
          netTax = incmevalues * 0.15;
        } else if (typePropertytype == 1) {
          netTax = incmevalues * 0.1;
        }
        Penalty = calculatePenaltyPayment(datapayments, dateContract, netTax);
        total = netTax + Penalty;
      } else {
        tax = incmevalues * 0.07;
        netTax = calculateProgressiveTax(incmevalues);
        discout = typePropertytype == 1 ? netTax - netTax * 0.25 : netTax;
        Penalty = calculatePenaltyPayment(datapayments, dateContract, discout);
        total = (discout - tax) + Penalty;
      }

      Get.to(Finalsubjugation());
    }
    update();
  }

  void resetAll() {
    Get.until((route) => Get.currentRoute == fromPage);
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }

  void BackFromRealestateincometype() {
    typeOvercome = 0;
  }

  void BackFromPropertytype() {
    typePropertytype = 0;
  }

  void BackFromIncomevalue() {
    incmevalue.clear();
    dataTheContract.clear();
    datapayment.clear();
    incmevalueErorr = null;
    datapaymentErorr = null;
    dataTheContractErorr = null;

    netTax = 0;
  }

  double calculateProgressiveTax(double value) {
    double tax = 0;

    // الشريحة 1 → 24 بنسبة 0%
    if (value <= 24000000) return 1000000;

    // الشريحة 2 → 24 بنسبة 23%
    if (value >= 24000001 && value >= 48000000) {
      tax += 24000000 * 0.23;
      print("==============tax $tax");
    }

    // الشريحة 3 → 48 بنسبة 27%
    if (value >= 480000001 && value >= 96000000) {
      tax += 48000000 * 0.27;
      print("==============tax2 $tax");
    }

    // الشريحة 4 → 96 بنسبة 30%
    if (value >= 96000001 && value >= 192000000) {
      tax += 96000000 * 0.30;
      print("==============tax4 $tax");
    }

    // الشريحة 5 → 192 بنسبة 33%
    if (value >= 192000001 && value >= 384000000) {
      tax += 192000000 * 0.33;
      print("==============tax5 $tax");
    }

    // ما فوق 384 بنسبة 35%
    if (value >= 384000001) {
      value = value - 384000000;
      tax += value * 0.35;
      print("==============valu $value");
      print("==============tax $tax");
    }

    if (tax < 1000000) {
      return 1000000;
    }
    return tax;
  }

  double calculatePenaltyPayment(
    DateTime? datePayment,
    DateTime? dataContract,
    double advance,
  ) {
    if (datePayment == null || dataContract == null) return 0;

    int monthsToAdd;

    switch (typeTypeofcollection) {
      case 1: // شهري
      case 5:
        monthsToAdd = 1;
        break;
      case 2: // ثلاثي
        monthsToAdd = 3;
        break;
      case 3: // سداسي
        monthsToAdd = 6;
        break;
      case 4: // سنوي
        monthsToAdd = 12;
        break;
      default:
        monthsToAdd = 1;
    }

    // تاريخ الاستحقاق
    DateTime dueDate = DateTime(
      dataContract.year,
      dataContract.month + monthsToAdd,
      dataContract.day,
    );

    // 🔹 حالة الدفع قبل الاستحقاق
    if (datePayment.month < dataContract.month + 20) {
      return 0;
    }

    // نهاية مهلة 20 يوم
    DateTime graceEnd = dueDate.add(const Duration(days: 20));

    // 🔹 داخل المهلة
    if (!datePayment.isAfter(graceEnd)) {
      return 0;
    }

    // 🔹 حساب الأشهر بعد انتهاء المهلة (نهمل السنة)
    int monthsLate = datePayment.month - graceEnd.month;

    if (monthsLate < 0) {
      monthsLate += 12;
    }

    double percent;

    if (monthsLate == 0) {
      percent = 0.10; // من 21 لنهاية نفس الشهر
    } else if (monthsLate == 1) {
      percent = 0.13;
    } else if (monthsLate == 2) {
      percent = 0.16;
    } else if (monthsLate == 3) {
      percent = 0.19;
    } else if (monthsLate == 4) {
      percent = 0.22;
    } else {
      percent = 0.25;
    }

    return advance * percent;
  }

  void backFromFinalsubjugation() {}

  void BackFromTypeofcollection() {
    typeTypeofcollection = 0;
  }

  bool validateAllFields() {
    bool hasError = false;

    // ======= التواريخ =======
    if (dataTheContract.text.isEmpty) {
      dataTheContractErorr = "تاريخ عقد الإيجار مطلوب".tr;
      hasError = true;
    } else {
      dataTheContractErorr = validInput(dataTheContract.text, 20, 3, "Text");
      if (dataTheContractErorr != null) hasError = true;
    }

    // if (datacollection.text.isEmpty) {
    //   datacollectionErorr = "تاريخ التحصيل مطلوب";
    //   hasError = true;
    // } else {
    //   datacollectionErorr = validInput(datacollection.text, 20, 4, "Text");
    //   if (datacollectionErorr != null) hasError = true;
    // }
    if (datapayment.text.isEmpty) {
      datapaymentErorr = "تاريخ عقد الإيجار مطلوب".tr;
      hasError = true;
    } else {
      datapaymentErorr = validInput(datapayment.text, 20, 3, "Text");
      if (datapaymentErorr != null) hasError = true;
    }

    incmevalueErorr = validInput(
      incmevalue.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    if (incmevalueErorr != null) hasError = true;

    update();
    return hasError;
  }


    
  

}
