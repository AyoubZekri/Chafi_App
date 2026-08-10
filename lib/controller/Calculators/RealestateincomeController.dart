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
import '../../view/screen/Calculators/different/RealEstateIncome/PeriodSelection.dart';
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
  int typeSelectedPeriod = 0;

  String? incmevalueErorr;
  String? dataTheContractErorr;
  String? datacollectionErorr;
  String? datapaymentErorr;
  String? otherIncomesErorr;
  String? collectionYearErorr;
  TextEditingController incmevalue = TextEditingController();
  TextEditingController otherIncomes = TextEditingController();
  TextEditingController dataTheContract = TextEditingController();
  TextEditingController datacollection = TextEditingController();
  TextEditingController datapayment = TextEditingController();
  TextEditingController collectionYear = TextEditingController();

  double netTax = 0;
  double Penalty = 0;
  double tax = 0;
  double incmevalues = 0;
  double total = 0;
  double discout = 0;
  double progressiveTotal = 0;

  String getIncomeTitle() {
    if (typeOvercome == 1) {
      return "قيمة الإيجار السنوي".tr;
    } else {
      if (typeTypeofcollection == 1) {
        return "قيمة الإيجار الشهري".tr;
      } else if (typeTypeofcollection == 2) {
        return "قيمة الإيجار الثلاثي".tr;
      } else if (typeTypeofcollection == 3) {
        return "قيمة الإيجار السداسي".tr;
      } else if (typeTypeofcollection == 4) {
        return "قيمة الإيجار السنوي".tr;
      } else {
        return "قيمة الإيجار".tr;
      }
    }
  }

  String getIncomeLabel() {
    if (typeOvercome == 1) {
      return "أدخل قيمة الإيجار السنوي".tr;
    } else {
      if (typeTypeofcollection == 1) {
        return "أدخل قيمة الإيجار الشهري".tr;
      } else if (typeTypeofcollection == 2) {
        return "أدخل قيمة الإيجار الثلاثي".tr;
      } else if (typeTypeofcollection == 3) {
        return "أدخل قيمة الإيجار السداسي".tr;
      } else if (typeTypeofcollection == 4) {
        return "أدخل قيمة الإيجار السنوي".tr;
      } else {
        return "أدخل قيمة الإيجار".tr;
      }
    }
  }

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
    if (typePropertytype == 0) {
      return showSnackbar("خطأ".tr, "يرجى اختيار نوع العقار.".tr, Colors.red);
    }

    if (typeOvercome == 1) {
      Get.to(IsAdvanceCollection());
    } else {
      Get.to(Typeofcollection());
    }
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

    if (typeTypeofcollection == 4) {
      Get.to(IsAdvanceCollection());
    } else {
      Get.to(() => PeriodSelection());
    }
  }

  void gotoIsAdvanceFromPeriod() {
    if (typeSelectedPeriod == 0) {
      return showSnackbar("خطأ".tr, "يرجى اختيار الفترة.".tr, Colors.red);
    }
    Get.to(IsAdvanceCollection());
  }

  void selectedPeriod(int i) {
    typeSelectedPeriod = i;
    update();
  }

  void BackFromPeriodSelection() {
    typeSelectedPeriod = 0;
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

    double otherIncomesValue =
        double.tryParse(otherIncomes.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;

    final dateContract = parseDate(dataTheContract.text);
    // final datacollections = parseDate(datacollection.text);
    final datapayments = parseDate(datapayment.text);

    if (!hasError) {
      double multiplier = 1;
      if (typeTypeofcollection == 1 && typeOvercome == 1) {
        multiplier = 12; // شهري
      } else if (typeTypeofcollection == 2 && typeOvercome == 1) {
        multiplier = 4; // ثلاثي
      } else if (typeTypeofcollection == 3 && typeOvercome == 1) {
        multiplier = 2; // سداسي
      } else if (typeTypeofcollection == 4 && typeOvercome == 1) {
        multiplier = 1; // سنوي
      } else if (typeTypeofcollection == 5 && typeOvercome == 1) {
        multiplier = 12; // سنوي
      }

      double annualizedIncome = incmevalues * multiplier;

      if (typeOvercome == 2 && annualizedIncome >= 180000000) {
        showSnackbar(
          "خطأ".tr,
          "قيمة التحصيل السنوي تتجاوز 1,800,000.00 دج. يرجى العودة وتغيير الاختيار الأول."
              .tr,
          Colors.red,
        );
        return;
      }

      if (typeOvercome == 1 && annualizedIncome < 180000000) {
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
        } else if (typePropertytype == 4) {
          netTax = incmevalues * 0.1;
        }
        Penalty = calculatePenaltyPayment(datapayments, dateContract, netTax);
        total = netTax + Penalty;
      } else {
        tax = incmevalues * 0.07;
        double totalIncome = incmevalues + otherIncomesValue;
        progressiveTotal = calculateProgressiveTax(totalIncome, multiplier);
        netTax = progressiveTotal - tax;
        discout = typePropertytype == 1 ? (netTax * 0.25) : 0;
        double baseAmount = netTax - discout;
        print("baseAmount ================  $baseAmount");
        Penalty = calculatePenaltyPayment(
          datapayments,
          dateContract,
          baseAmount,
        );
        total = (netTax - discout) + Penalty;
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
    otherIncomes.clear();
    dataTheContract.clear();
    datapayment.clear();
    incmevalueErorr = null;
    otherIncomesErorr = null;
    datapaymentErorr = null;
    dataTheContractErorr = null;
    collectionYear.clear();
    datacollection.clear();
    collectionYearErorr = null;
    datacollectionErorr = null;
    netTax = 0;
  }

  double calculateProgressiveTax(double value, double multiplier) {
    double tax = 0;

    double bracket1 = 24000000 / multiplier;
    double bracket2 = 48000000 / multiplier;
    double bracket3 = 96000000 / multiplier;
    double bracket4 = 192000000 / multiplier;
    double bracket5 = 384000000 / multiplier;
    double minTax = 1000000 / multiplier;

    if (value <= bracket1) {
      return minTax;
    }

    if (value > bracket1) {
      double taxable = (value > bracket2 ? bracket2 : value) - bracket1;
      tax += taxable * 0.23;
    }

    if (value > bracket2) {
      double taxable = (value > bracket3 ? bracket3 : value) - bracket2;
      tax += taxable * 0.27;
    }

    if (value > bracket3) {
      double taxable = (value > bracket4 ? bracket4 : value) - bracket3;
      tax += taxable * 0.30;
    }

    if (value > bracket4) {
      double taxable = (value > bracket5 ? bracket5 : value) - bracket4;
      tax += taxable * 0.33;
    }

    if (value > bracket5) {
      double taxable = value - bracket5;
      tax += taxable * 0.35;
    }

    if (tax < minTax) {
      return minTax;
    }
    return tax;
  }

  int getFirstMonthOfPeriod(DateTime contractDate) {
    switch (typeTypeofcollection) {
      case 1:
        return typeSelectedPeriod > 0 ? typeSelectedPeriod : 1;
      case 2:
        return typeSelectedPeriod > 0 ? ((typeSelectedPeriod - 1) * 3) + 1 : 1;
      case 3:
        return typeSelectedPeriod > 0 ? ((typeSelectedPeriod - 1) * 6) + 1 : 1;
      case 4:
        return 1;
      default:
        return contractDate.month;
    }
  }

  int getLastMonthOfPeriod(DateTime contractDate) {
    switch (typeTypeofcollection) {
      case 1:
        return typeSelectedPeriod > 0 ? typeSelectedPeriod : 1;
      case 2:
        return typeSelectedPeriod > 0 ? typeSelectedPeriod * 3 : 3;
      case 3:
        return typeSelectedPeriod > 0 ? typeSelectedPeriod * 6 : 6;
      case 4:
        return 12;
      default:
        return contractDate.month;
    }
  }

  double calculatePenaltyPayment(
    DateTime? datePayment,
    DateTime? dataContract,
    double advance,
  ) {
    if (datePayment == null || dataContract == null) return 0;

    DateTime graceEnd;

    int collectionYr = int.tryParse(collectionYear.text) ?? dataContract.year;
    DateTime? collDate = parseDate(datacollection.text);

    if (typeIsAdvance == 1) {
      if (collDate != null) {
        graceEnd = DateTime(collDate.year, collDate.month + 1, 20);
      } else {
        int firstMonth = getFirstMonthOfPeriod(dataContract);
        graceEnd = DateTime(collectionYr, firstMonth + 1, 20);
      }
    } else {
      if (collDate != null) {
        graceEnd = DateTime(collDate.year, collDate.month + 1, 20);
      } else {
        int lastMonth = getLastMonthOfPeriod(dataContract);
        graceEnd = DateTime(collectionYr, lastMonth + 1, 20);
      }
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
      percent = 0.15; // من 21 لنهاية نفس الشهر
    } else if (monthsLate == 1) {
      percent = 0.23;
    } else if (monthsLate == 2) {
      percent = 0.26;
    } else if (monthsLate == 3) {
      percent = 0.29;
    } else if (monthsLate == 4) {
      percent = 0.32;
    } else {
      percent = 0.35;
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

    if (datacollection.text.isNotEmpty) {
      datacollectionErorr = validInput(datacollection.text, 20, 4, "Text");
      if (datacollectionErorr != null) {
        hasError = true;
      } else if (typeIsAdvance == 1) {
        DateTime? collDate = parseDate(datacollection.text);
        DateTime? contractDate = parseDate(dataTheContract.text);
        int collYear =
            int.tryParse(collectionYear.text) ??
            (contractDate?.year ?? DateTime.now().year);

        if (collDate != null && contractDate != null) {
          int firstMonth = getFirstMonthOfPeriod(contractDate);
          if (collDate.year > collYear ||
              (collDate.year == collYear && collDate.month > firstMonth)) {
            datacollectionErorr =
                "لا يمكن أن يكون تاريخ التحصيل بعد الشهر الأول من الفترة".tr;
            hasError = true;
          }
        }
      }
    } else {
      datacollectionErorr = null;
    }
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

    collectionYearErorr = validInput(collectionYear.text, 4, 4, "int");
    if (collectionYearErorr != null) hasError = true;

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
