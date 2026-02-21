import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/constant/routes.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/ArbitrarySystem.dart/G12/ShwopenaltyG12.dart';
import '../../view/screen/Calculators/ArbitrarySystem.dart/G12/TaxinputdataRecorde.dart';

class G12controller extends GetxController {
  String? dateofpaymentErorr;
  String? dateofdepositandErorr;
  String? productionErorr;
  String? g12Erorr;
  String? profitmarginErorr;
  String? extractedfromSourceErorr;
  String? selfcontractorErorr;
  String? otherActivityErorr;

  int activityType = 0;
  TextEditingController production = TextEditingController();
  TextEditingController g12 = TextEditingController();

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

  double penaltyfinalpayment = 0;
  double penaltyfinaldepositand = 0;
  double netTax = 0;
  double? total = 0;
  double? penalty = 0;
  double? penaltypyment = 0;

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
      return showSnackbar(
        "خطأ".tr,
        "إختر نوع النشاط الخاص بك أولا".tr,
        Colors.red,
      );
    }
    Get.to(Taxinputdatarecorde());
  }

  double calculatePenaltypositand(
    DateTime? datepositand,
    DateTime dueDate,
    double advance,
  ) {
    if (datepositand == null) return 0;
    if (!datepositand.isAfter(dueDate)) return 0;

    int monthsLate =
        (datepositand.year - dueDate.year) * 12 +
        (datepositand.month - dueDate.month);

    double percent;
    double fixedPenalty;

    if (monthsLate == 0) {
      percent = 0.20;
      fixedPenalty = 2500;
    } else if (monthsLate == 1) {
      percent = 0.20;
      fixedPenalty = 5000;
    } else {
      percent = 0.25;
      fixedPenalty = 20000;
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

    int monthsLate =
        (datePayment.year - dueDate.year) * 12 +
        (datePayment.month - dueDate.month);

    double percent;

    if (monthsLate == 0) {
      percent = 0.20;
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

  double calculatepositand(DateTime? date, DateTime dueDate, double advance) {
    if (date == null) return 0;
    if (!date.isAfter(dueDate)) return 0;

    int monthsLate =
        (date.year - dueDate.year) * 12 + (date.month - dueDate.month);

    double percent;

    if (monthsLate == 0) {
      percent = 2500;
    } else if (monthsLate == 1) {
      percent = 5000;
    } else {
      percent = 20000;
    }
    return percent;
  }

  void calculateTax() {
    if (production.text.isEmpty &&
        profitmargin.text.isEmpty &&
        extractedfromSource.text.isEmpty &&
        selfcontractor.text.isEmpty &&
        otherActivity.text.isEmpty) {
      return showSnackbar(
        "خطأ".tr,
        "لا يمكن ان تكون كل قيم الضرائب فارغة".tr,
        Colors.red,
      );
    }

    if (validateAllFields()) return;
    productions = double.tryParse(production.text) ?? 0;
    other = double.tryParse(otherActivity.text) ?? 0;
    profitmargins = double.tryParse(profitmargin.text) ?? 0;
    extractedfromSources = double.tryParse(extractedfromSource.text) ?? 0;
    selfcontractors = double.tryParse(selfcontractor.text) ?? 0;

    double taxProduction = productions * 0.05;
    double taxother = other * 0.12;
    double taxprofitmargins = profitmargins * 0.05;
    double taxextractedfromSources = extractedfromSources * 0.05;
    double taxselfcontractors = selfcontractors * 0.005;
    netTax =
        taxProduction +
        taxother +
        taxprofitmargins +
        taxextractedfromSources +
        taxselfcontractors;

    final dueDatedepositand = DateTime(DateTime.now().year, 7, 1);
    // final dueDatede = DateTime(DateTime.now().year, 1, 21);

    DateTime? parseDate(String text) {
      if (text.isEmpty) return null;
      try {
        return DateFormat('yyyy/MM/dd').parseStrict(text);
      } catch (_) {
        try {
          return DateFormat('yyyy-MM-dd').parseStrict(text);
        } catch (_) {
          return null;
        }
      }
    }

    final datepositand = parseDate(dateofdepositand.text);
    final datepayment = parseDate(dateofpayment.text);

    penalty = calculatePenaltypositand(datepositand, dueDatedepositand, netTax);
    penaltypyment = calculatePenaltyPayment(
      datepayment,
      dueDatedepositand,
      netTax,
    );

    Get.to(Shwopenaltyg12());
    print("================netTax $netTax");
    print("================penalty $penalty");
    total = netTax + penalty! + penaltypyment!;
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
    Get.until(
      (route) => Get.currentRoute == Approutes.calculatorsofSystemSimpli,
    );
  }

  void backFromCalTypeActivite() {
    activityType = 0;
    Get.back();
  }

  void backFromTaxInput() {
    production.clear();
    profitmargin.clear();
    extractedfromSource.clear();
    selfcontractor.clear();
    otherActivity.clear();
    dateofdepositand.clear();
    dateofpayment.clear();
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

    if (dateofpayment.text.isEmpty) {
      dateofpaymentErorr = "تاريخ الدفع مطلوب".tr;
      hasError = true;
    } else {
      dateofpaymentErorr = validInput(dateofpayment.text, 20, 3, "Text");
      if (dateofpaymentErorr != null) hasError = true;
    }

    // ======= الحقول الخاصة بالنشاط =======
    if (activityType == 2) {
      extractedfromSourceErorr = validInput(
        extractedfromSource.text,
        20,
        3,
        "Text",
      );
      if (extractedfromSourceErorr != null) hasError = true;
    } else {
      extractedfromSourceErorr = null;
    }

    if (activityType == 1) {
      selfcontractorErorr = validInput(selfcontractor.text, 20, 3, "Text");
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
      String text = (field['controller'] as TextEditingController).text;

      if (!foundNonEmpty && text.isNotEmpty) {
        String? error = validInput(text, 20, 3, "Text");
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
}
