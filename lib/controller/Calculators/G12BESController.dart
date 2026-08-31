import 'package:chafi/view/screen/Calculators/ArbitrarySystem.dart/G12BES/ShwopenaltyG12BES.dart';
import 'package:chafi/view/screen/Calculators/ArbitrarySystem.dart/G12BES/TaxinputdataRecordeG12BES.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';

class G12bescontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;
  String? dateofpaymentErorr;
  String? dateofdepositandErorr;
  String? productionErorr;
  String? g12Erorr;
  String? profitmarginErorr;
  String? extractedfromSourceErorr;
  String? selfcontractorErorr;
  String? otherActivityErorr;
  String? dataTaxErorr;

  // أخطاء حقول التقديري للنشاطات 3
  String? g12ProductionErorr;
  String? g12ProfitMarginErorr;
  String? g12OtherActivityErorr;

  int activityType = 0;
  TextEditingController production = TextEditingController();
  TextEditingController g12 = TextEditingController();

  // حقول التقديري للنشاطات 3
  TextEditingController g12Production = TextEditingController();
  TextEditingController g12ProfitMargin = TextEditingController();
  TextEditingController g12OtherActivity = TextEditingController();

  // هامش ربح المواد المدعمة
  TextEditingController profitmargin = TextEditingController();

  // إقتطاع من المصدر
  TextEditingController extractedfromSource = TextEditingController();

  // كنترولر النشاطات الأخرى
  TextEditingController otherActivity = TextEditingController();

  // المقاول الذاتي
  TextEditingController selfcontractor = TextEditingController();

  // تاريخ الايداع والدفع
  TextEditingController dateofdepositand = TextEditingController();
  TextEditingController dateofpayment = TextEditingController();
  TextEditingController dataTax = TextEditingController();

  double penaltyfinalpayment = 0;
  double penaltyfinaldepositand = 0;
  double netTax = 0;
  double total = 0;
  double deff = 0;
  double penalty = 0;
  double penaltypyment = 0;
  double currentNetTax = 0;

  double productions = 0;
  double profitmargins = 0;
  double extractedfromSources = 0;
  double selfcontractors = 0;
  double other = 0;

  selectedPerson(int i) {
    activityType = i;
    update();
  }

  void gotodatacreate() {
    if (activityType == 0) {
      return showSnackbar("خطأ".tr, "إختر نوع النشاط أولا".tr, Colors.red);
    }
    Get.to(Taxinputdatarecordeg12bes());
  }

  int _getCustomMonthsLate(DateTime date, DateTime dueDate) {
    if (date.isBefore(DateTime(dueDate.year, 2, 20))) return 0;
    if (date.isBefore(DateTime(dueDate.year, 3, 21))) return 1;
    if (date.isBefore(DateTime(dueDate.year, 4, 21))) return 2;
    if (date.isBefore(DateTime(dueDate.year, 5, 22))) return 3;
    if (date.isBefore(DateTime(dueDate.year, 6, 22))) return 4;
    return 5;
  }

  double calculatePenaltypositand(
    DateTime? datepositand,
    DateTime dueDate,
    double advance,
  ) {
    if (datepositand == null) return 0;
    if (!datepositand.isAfter(dueDate)) return 0;

    int monthsLate = _getCustomMonthsLate(datepositand, dueDate);

    double percent;
    double fixedPenalty;

    if (monthsLate == 0) {
      percent = 0.10;
      fixedPenalty = 250000;
    } else if (monthsLate == 1) {
      percent = 0.20;
      fixedPenalty = 500000;
    } else {
      percent = 0.25;
      fixedPenalty = 1000000;
    }

    // إذا عنده مبلغ نحسب نسبة
    if (advance > 0) {
      return advance * percent;
    }

    // إذا ما عندوش مبلغ نرجع غرامة ثابتة
    return fixedPenalty;
  }

  double calculatePenaltyPayment(
    DateTime? datePayment,
    DateTime dueDate,
    double advance,
  ) {
    if (datePayment == null) return 0;
    if (!datePayment.isAfter(dueDate)) return 0;

    int monthsLate = _getCustomMonthsLate(datePayment, dueDate);

    double percent;

    if (monthsLate == 0) {
      percent = 0.10;
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

  double calculatepositand(DateTime? date, DateTime? dueDate) {
    print("===================date $date");
    print("===================dueDate $dueDate");
    if (date == null) return 0;
    if (!date.isAfter(dueDate!)) return 0;

    int monthsLate = _getCustomMonthsLate(date, dueDate);

    double percent;

    if (monthsLate == 0) {
      percent = 250000;
    } else if (monthsLate == 1) {
      percent = 500000;
    } else {
      percent = 2000000;
    }
    return percent;
  }

  void calculateTax() {
    if (activityType == 3 &&
        production.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        profitmargin.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        extractedfromSource.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        selfcontractor.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        otherActivity.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty) {
      return showSnackbar(
        "خطأ".tr,
        "لا يمكن ان تكون كل قيم الضرائب فارغة".tr,
        Colors.red,
      );
    }
    if (validateAllFields()) return;

    productions =
        double.tryParse(production.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    other =
        double.tryParse(otherActivity.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    profitmargins =
        double.tryParse(profitmargin.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    extractedfromSources =
        double.tryParse(
          extractedfromSource.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    selfcontractors =
        double.tryParse(
          selfcontractor.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    double g12b =
        double.tryParse(g12.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    netTax = 0;

    if (activityType == 3) {
      double g12p =
          double.tryParse(
            g12Production.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      double g12pm =
          double.tryParse(
            g12ProfitMargin.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      double g12o =
          double.tryParse(
            g12OtherActivity.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;

      double diffProduction = (productions - g12p) > 0
          ? (productions - g12p)
          : 0;
      double diffProfitMargin = (profitmargins - g12pm) > 0
          ? (profitmargins - g12pm)
          : 0;
      double diffOtherActivity = (other - g12o) > 0 ? (other - g12o) : 0;

      netTax =
          (diffProduction * 0.05) +
          (diffProfitMargin * 0.05) +
          (diffOtherActivity * 0.12);
    } else if (activityType == 1) {
      double diffSelfContractor = (selfcontractors - g12b) > 0
          ? (selfcontractors - g12b)
          : 0;
      netTax = (diffSelfContractor * 0.005);
    } else if (activityType == 2) {
      double diffExtracted = (extractedfromSources - g12b) > 0
          ? (extractedfromSources - g12b)
          : 0;
      netTax = (diffExtracted * 0.05);
    }

    if (activityType == 1) {
      netTax = netTax < 1000000 ? 1000000 : netTax;
    } else {
      netTax = netTax < 3000000 ? 3000000 : netTax;
    }

    final year = int.parse(dataTax.text);
    final dueDatedepositand = DateTime(year, 1, 20);
    final dueDatede = DateTime(year, 1, 20);
    final datepositand = parseDate(dateofdepositand.text);
    final datepayment = parseDate(dateofpayment.text);
    print("================netTax $netTax");
    penalty = netTax <= 0
        ? calculatepositand(datepositand, dueDatede)
        : calculatePenaltypositand(datepositand, dueDatedepositand, netTax);
    penaltypyment = netTax > 0
        ? calculatePenaltyPayment(datepayment, dueDatedepositand, netTax)
        : 0;

    Get.to(Shwopenaltyg12bes());
    print("================penalty $penalty");
    print("================penaltypyment $penaltypyment");
    total = netTax + penalty + penaltypyment;
  }

  void resetAll() {
    activityType = 0;
    penaltyfinalpayment = 0;
    penaltyfinaldepositand = 0;
    netTax = 0;
    total = 0;
    penalty = 0;
    penaltypyment = 0;
    productions = 0;
    profitmargins = 0;
    extractedfromSources = 0;
    selfcontractors = 0;
    other = 0;
    production.clear();
    profitmargin.clear();
    extractedfromSource.clear();
    selfcontractor.clear();
    otherActivity.clear();
    dateofdepositand.clear();
    dateofpayment.clear();
    dataTax.clear();
    Get.until((route) => Get.currentRoute == fromPage);
  }

  void backFromTypeacteviteg12bes() {
    activityType = 0;
    Get.back();
  }

  void backFromTaxInput() {
    g12.clear();
    production.clear();
    profitmargin.clear();
    extractedfromSource.clear();
    selfcontractor.clear();
    otherActivity.clear();
    dateofdepositand.clear();
    dateofpayment.clear();
    dataTax.clear();
    Get.back();
  }

  void backFromPenaltyDetails() {
    penaltyfinalpayment = 0;
    penaltyfinaldepositand = 0;
    netTax = 0;
    total = 0;
    penalty = 0;
    penaltypyment = 0;
    productions = 0;
    profitmargins = 0;
    extractedfromSources = 0;
    selfcontractors = 0;
    other = 0;
    Get.back();
  }

  bool validateAllFields() {
    bool hasError = false;

    // ======= التواريخ =======
    if (dateofdepositand.text.isEmpty) {
      dateofdepositandErorr = "تاريخ الإيداع مطلوب".tr;
      hasError = true;
    } else {
      dateofdepositandErorr = validInput(dateofdepositand.text, 20, 3, "Text");
      if (dateofdepositandErorr != null) hasError = true;
    }

    if (currentNetTax > 0) {
      if (dateofpayment.text.isEmpty) {
        dateofpaymentErorr = "تاريخ الدفع مطلوب".tr;
        hasError = true;
      } else {
        dateofpaymentErorr = validInput(dateofpayment.text, 20, 4, "Text");
        if (dateofpaymentErorr != null) hasError = true;
      }
    } else {
      dateofpaymentErorr = null;
    }

    if (dataTax.text.isEmpty) {
      dataTaxErorr = "تاريخ التصريح مطلوب".tr;
      hasError = true;
    } else {
      dataTaxErorr = validInput(dataTax.text, 20, 3, "Text");
      if (dataTaxErorr != null) hasError = true;
    }

    if (activityType != 3) {
      g12Erorr = validInput(g12.text, 20, 4, "Text");
      if (g12Erorr != null) hasError = true;
    } else {
      g12ProductionErorr = validInput(g12Production.text, 20, 4, "Text");
      if (g12ProductionErorr != null && g12Production.text.isNotEmpty)
        hasError = true;

      g12ProfitMarginErorr = validInput(g12ProfitMargin.text, 20, 4, "Text");
      if (g12ProfitMarginErorr != null && g12ProfitMargin.text.isNotEmpty)
        hasError = true;

      g12OtherActivityErorr = validInput(g12OtherActivity.text, 20, 4, "Text");
      if (g12OtherActivityErorr != null && g12OtherActivity.text.isNotEmpty)
        hasError = true;
    }

    // ======= الحقول الخاصة بالنشاط =======
    if (activityType == 2) {
      extractedfromSourceErorr = validInput(
        extractedfromSource.text.replaceAll(RegExp(r'[^0-9]'), ''),
        20,
        1,
        "Text",
      );
      if (extractedfromSourceErorr != null) hasError = true;
    } else {
      extractedfromSourceErorr = null;
    }

    if (activityType == 1) {
      selfcontractorErorr = validInput(
        selfcontractor.text.replaceAll(RegExp(r'[^0-9]'), ''),
        20,
        4,
        "Text",
      );
      if (selfcontractorErorr != null) hasError = true;
    } else {
      selfcontractorErorr = null;
    }

    // ======= باقي الحقول المالية =======
    final fields = [
      {
        'controller': production,
        'setter': (String? val) => productionErorr = val,
      },
      {
        'controller': profitmargin,
        'setter': (String? val) => profitmarginErorr = val,
      },
      {
        'controller': otherActivity,
        'setter': (String? val) => otherActivityErorr = val,
      },
    ];

    bool foundNonEmpty = false;

    for (var field in fields) {
      String text = (field['controller'] as TextEditingController).text
          .replaceAll(RegExp(r'[^0-9]'), '');

      if (!foundNonEmpty && text.isNotEmpty) {
        String? error = validInput(text, 20, 4, "Text");
        (field['setter'] as Function)(error);
        if (error != null) hasError = true;
        foundNonEmpty = true;
      } else {
        (field['setter'] as Function)(null);
      }
    }

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
    production.addListener(calculateLiveNetTax);
    otherActivity.addListener(calculateLiveNetTax);
    profitmargin.addListener(calculateLiveNetTax);
    extractedfromSource.addListener(calculateLiveNetTax);
    selfcontractor.addListener(calculateLiveNetTax);
    g12.addListener(calculateLiveNetTax);
    g12Production.addListener(calculateLiveNetTax);
    g12ProfitMargin.addListener(calculateLiveNetTax);
    g12OtherActivity.addListener(calculateLiveNetTax);
    super.onInit();
  }

  void calculateLiveNetTax() {
    double p =
        double.tryParse(production.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    double o =
        double.tryParse(otherActivity.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    double pm =
        double.tryParse(profitmargin.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    double e =
        double.tryParse(
          extractedfromSource.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    double s =
        double.tryParse(
          selfcontractor.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    double g12b =
        double.tryParse(g12.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    double liveNet = 0;

    if (activityType == 3) {
      double g12p =
          double.tryParse(
            g12Production.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      double g12pm =
          double.tryParse(
            g12ProfitMargin.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;
      double g12o =
          double.tryParse(
            g12OtherActivity.text.replaceAll(RegExp(r'[^0-9]'), ''),
          ) ??
          0;

      double diffProduction = (p - g12p) > 0 ? (p - g12p) : 0;
      print(
        "======================================= diffProduction==$diffProduction",
      );
      double diffProfitMargin = (pm - g12pm) > 0 ? (pm - g12pm) : 0;
      print(
        "===  ====================================diffProfitMargin==$diffProfitMargin",
      );
      double diffOtherActivity = (o - g12o) > 0 ? (o - g12o) : 0;
      print(
        "======================================= diffOtherActivity==$diffOtherActivity",
      );

      liveNet =
          (diffProduction * 0.05) +
          (diffProfitMargin * 0.05) +
          (diffOtherActivity * 0.12);
      print("======================================liveNet==$liveNet");
    } else if (activityType == 1) {
      double diffSelfContractor = (s - g12b) > 0 ? (s - g12b) : 0;
      liveNet = (diffSelfContractor * 0.005);
    } else if (activityType == 2) {
      double diffExtracted = (e - g12b) > 0 ? (e - g12b) : 0;
      liveNet = (diffExtracted * 0.05);
    }

    if (activityType == 1) {
      liveNet = liveNet < 1000000 ? 1000000 : liveNet;
    } else {
      liveNet = liveNet < 3000000 ? 3000000 : liveNet;
    }

    if (currentNetTax != liveNet) {
      currentNetTax = liveNet;
      update();
    }
  }
}
