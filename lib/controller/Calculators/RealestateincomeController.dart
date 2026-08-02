import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/FinalSubjugation.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/IncomeValue.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/PropertyType.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/TypeOfCollection.dart';
import '../../view/screen/Calculators/different/RealEstateIncome/IsAdvanceCollection.dart';

class Realestateincomecontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;
  int typeOvercome = 0; //YES 1 NO 2
  int typePropertytype = 0; //YES 1 NO 2
  int typeTypeofcollection = 0; // 1monthly 2tripartite 3six 4annual 5no
  int typeIsAdvance = 0; //YES 1 NO 2

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
    if (typeIsAdvance == 0) {
      return showSnackbar(
        "خطأ".tr,
        "يرجى اختيار هل التحصيل مسبق أم لا.".tr,
        Colors.red,
      );
    }
    Get.to(Incomevalue());
  }

  void gotoIsAdvance() {
    if (typeTypeofcollection == 0) {
      return showSnackbar("خطأ".tr, "يرجى اختيار نوع التحصيل.".tr, Colors.red);
    }
    Get.to(IsAdvanceCollection());
  }

  void selectedIsAdvance(int i) {
    typeIsAdvance = i;
    update();
  }

  void BackFromIsAdvance() {
    Get.back();
  }

  void calcul() {
    bool hasError = validateAllFields();
    incmevalues =
        double.tryParse(incmevalue.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final dateContract = parseDate(dataTheContract.text);
    // final datacollections = parseDate(datacollection.text);
    final datapayments = parseDate(datapayment.text);

    if (!hasError) {
      double multiplier = 1;
      if (typeTypeofcollection == 1) {
        multiplier = 12; // شهري
      } else if (typeTypeofcollection == 2) {
        multiplier = 4; // ثلاثي
      } else if (typeTypeofcollection == 3) {
        multiplier = 2; // سداسي
      } else if (typeTypeofcollection == 4) {
        multiplier = 1; // سنوي
      }

      double annualizedIncome = incmevalues * multiplier;

      if (typeOvercome == 2 && annualizedIncome > 180000000) {
        showSnackbar(
          "خطأ".tr,
          "قيمة التحصيل السنوي تتجاوز 1,800,000.00 دج. يرجى العودة وتغيير الاختيار الأول."
              .tr,
          Colors.red,
        );
        return;
      }

      if (typeOvercome == 1 && annualizedIncome <= 180000000) {
        showSnackbar(
          "خطأ".tr,
          "قيمة التحصيل السنوي لا تتجاوز 1,800,000.00 دج. يرجى العودة وتغيير الاختيار الأول."
              .tr,
          Colors.red,
        );
        return;
      }
      if (typeOvercome == 2) {
        if (typePropertytype == 1) {
          netTax = incmevalues * 0.07;
        } else if ((typePropertytype == 2 || typePropertytype == 3)) {
          netTax = incmevalues * 0.15;
        } else if (typePropertytype == 1) {
          netTax = incmevalues * 0.1;
        }
        Penalty = calculatePenaltyPayment(
          datapayments,
          dateContract,
          incmevalues,
        );
        total = netTax + Penalty;
      } else {
        tax = incmevalues * 0.07;
        netTax = calculateProgressiveTax(incmevalues);
        discout = typePropertytype == 1 ? (incmevalues * 0.25) : 0;
        Penalty = calculatePenaltyPayment(
          datapayments,
          dateContract,
          incmevalues,
        );
        total = (netTax - discout - tax) + Penalty;
      }

      Get.to(Finalsubjugation());
    }
    update();
  }

  void resetAll() {
    Get.until((route) => Get.currentRoute == fromPage);
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

    if (value <= 24000000) {
      return 1000000;
    }

    if (value > 24000000) {
      double taxable = (value > 48000000 ? 48000000 : value) - 24000000;
      tax += taxable * 0.23;
    }

    if (value > 48000000) {
      double taxable = (value > 96000000 ? 96000000 : value) - 48000000;
      tax += taxable * 0.27;
    }

    if (value > 96000000) {
      double taxable = (value > 192000000 ? 192000000 : value) - 96000000;
      tax += taxable * 0.30;
    }

    if (value > 192000000) {
      double taxable = (value > 384000000 ? 384000000 : value) - 192000000;
      tax += taxable * 0.33;
    }

    if (value > 384000000) {
      double taxable = value - 384000000;
      tax += taxable * 0.35;
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

    DateTime graceEnd;

    if (typeIsAdvance == 1) {
      // حالة التحصيل المسبق: المهلة تنتهي في 20 من الشهر الثاني
      graceEnd = DateTime(dataContract.year, dataContract.month + 1, 20);
    } else {
      // حالة التحصيل غير المسبق: الاعتماد على نوع التحصيل
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
      // المهلة تنتهي في 20 من الشهر الموالي لفترة التحصيل
      graceEnd = DateTime(
        dataContract.year,
        dataContract.month + monthsToAdd,
        20,
      );
    }

    // إذا تم الدفع داخل المهلة القانونية (قبل أو في نفس يوم 20)
    if (!datePayment.isAfter(graceEnd)) {
      return 0;
    }

    // حساب عدد أشهر التأخير
    // يتم حساب الفرق الإجمالي بالأشهر بين تاريخ الدفع ونهاية المهلة
    int monthsLate =
        (datePayment.year - graceEnd.year) * 12 +
        (datePayment.month - graceEnd.month);

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
