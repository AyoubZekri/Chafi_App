import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/view/screen/Calculators/Simplified%20system/Capital.dart';
import 'package:chafi/view/screen/Calculators/Simplified%20system/IRG/TaxInpout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/functions/Snacpar.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../view/screen/Calculators/Simplified system/IBS/CreateACompany.dart';
import '../../view/screen/Calculators/Simplified system/PenaltyDetailsScreen.dart';
import '../../view/screen/Calculators/Simplified system/IBS/TaxInputPage.dart';
import '../../view/screen/Calculators/Simplified system/IBS/TaxPrepaymentsPage.dart';
import '../../view/screen/Calculators/Simplified system/IBS/TxsLastyear.dart';
import '../../view/screen/Calculators/Simplified system/IRG/CreateRecord.dart';

class Simplifiedsystemcontroller extends GetxController {
  String? fromPage;

  String? taxLastyearErorr;
  String? surplusErorr;
  String? dataCreateErorr;
  String? capitalErorr;

  String? productionErorr;
  String? otherActivityErorr;
  String? constructionErorr;
  String? advance1DateErorr;
  String? advance2DateErorr;
  String? advance3DateErorr;
  String? finalPaymentDateErorr;
  String? dataTaxErorr;

  int personType = 0;

  //
  TextEditingController TaxLastyear = TextEditingController();
  TextEditingController dataCreate = TextEditingController();
  TextEditingController surplus = TextEditingController();
  TextEditingController capital = TextEditingController();
  // كنترولر نشاط إنتاج السلع
  TextEditingController production = TextEditingController();

  // كنترولر نشاط البناء والأشغال العمومية
  TextEditingController construction = TextEditingController();

  // كنترولر النشاطات الأخرى
  TextEditingController otherActivity = TextEditingController();

  // كنترولر تاريخ دفع التسبيقات
  TextEditingController advance1Date = TextEditingController();
  TextEditingController advance2Date = TextEditingController();
  TextEditingController advance3Date = TextEditingController();

  // كنترولر تاريخ الدفع النهائي
  TextEditingController finalPaymentDate = TextEditingController();
  TextEditingController dataTax = TextEditingController();

  double penalty1 = 0;
  double penalty2 = 0;
  double penalty3 = 0;
  double penaltyfinal = 0;
  double? surplusLeft = 0;
  double? advance1 = 0;
  double? advance2 = 0;
  double? advance3 = 0;
  double netTax = 0;

  double? type = 0;
  double? total = 0;

  double productions = 0;
  double constructions = 0;
  double other = 0;
  //////////////////////////////////////////////

  selectedPerson(int i) {
    personType = i;
    update();
  }

  gotodatacreate() {
    if (personType == 0) {
      showSnackbar("خطأ".tr, "يرجى اختيار طبيعة الشخص".tr, Colors.red);
      return;
    }
    if (personType == 2) {
      Get.to(Createacompany()); // شخص معنوي ibs
    } else {
      Get.to(Createrecord()); // شخص طبيعي IRG
    }
  }

  void gotoAfter() {
    dataCreateErorr = validInput(dataCreate.text, 20, 3, "Text".tr);
    if (dataCreateErorr != null) {
      update();
      return;
    }
    final yearStr = dataCreate.text.substring(0, 4);
    final year = int.tryParse(yearStr);
    final currentYear = DateTime.now().year;

    print("==============$year");
    print("===============$currentYear");

    if (year == currentYear && personType == 2) {
      type = 1; // شركة في عامها الاول
      Get.to(Capital());
    } else if (year! < currentYear) {
      type = 2; // شركة او مؤسسة بعد عامها الاول
      Get.to(Txslastyear());
    } else if (year == currentYear && personType == 1) {
      Get.to(Taxinpout());
      type = 3; // مؤسسة في عامها الاول
    }
    update();
  }

  void divideTaxToAdvance() {
    taxLastyearErorr = validInput(
      TaxLastyear.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      3,
      "int".tr,
    );
    surplusErorr = validInput(
      surplus.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      3,
      "int".tr,
    );
    if (taxLastyearErorr != null || surplusErorr != null) {
      update();
      return;
    }
    double? tax = double.tryParse(
      TaxLastyear.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );
    double? remainingSurplus = double.tryParse(
      surplus.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    if (tax == null || remainingSurplus == null) {
      Get.snackbar(
        "خطأ".tr,
        "الرجاء إدخال أرقام صحيحة للضريبة والفائض".tr,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    List<double> advances = [0.3, 0.3, 0.3].map((p) => tax * p).toList();
    surplusLeft = remainingSurplus;

    for (int i = 0; i < advances.length; i++) {
      if (surplusLeft! >= advances[i]) {
        surplusLeft = surplusLeft! - advances[i];
        advances[i] = 0;
      } else {
        advances[i] = advances[i] - surplusLeft!;
        surplusLeft = 0;
      }
    }

    advance1 = advances[0];
    advance2 = advances[1];
    advance3 = advances[2];

    print("التسبيق 1: $advance1");
    print("التسبيق 2: $advance2");
    print("التسبيق 3: $advance3");
    print("الفائض المتبقي: $surplusLeft");

    Get.to(TaxPrepaymentsPage());
    update();
  }

  void divideTaxToCapital() {
    capitalErorr = validInput(
      capital.text
          .replaceAll(RegExp(r'[^0-9]'), '')
          .replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      3,
      "int".tr,
    );
    if (capitalErorr != null) {
      update();
      return;
    }
    double? taxValue = double.tryParse(
      capital.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );

    if (taxValue == null) {
      Get.snackbar(
        "خطأ".tr,
        "الرجاء إدخال قيمة صحيحة لرأس المال".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    advance1 = taxValue * 0.3;
    advance2 = taxValue * 0.3;
    advance3 = taxValue * 0.3;

    print("التسبيق 1: $advance1");
    print("التسبيق 2: $advance2");
    print("التسبيق 3: $advance3");

    // الانتقال للصفحة التالية
    Get.to(TaxPrepaymentsPage());
  }

  gotoDetective() {
    personType == 2 ? Get.to(Taxinputpage()) : Get.to(Taxinpout());
  }

  double calculatePenalty(
    DateTime? paymentDate,
    DateTime dueDate,
    double advance,
  ) {
    if (paymentDate == null || advance == 0) return 0;

    // لو الدفع قبل أو يوم الاستحقاق → لا عقوبة
    if (!paymentDate.isAfter(dueDate)) return 0;

    int monthsLate =
        (paymentDate.year - dueDate.year) * 12 +
        (paymentDate.month - dueDate.month);

    // نسبة العقوبة حسب الشهر
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
    } else if (monthsLate == 5) {
      percent = 0.25;
    } else {
      percent = 0.25; // كل شهر بعده
    }

    return advance * percent;
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

  double finalcalculatePenalty(
    DateTime? paymentDate,
    DateTime dueDate,
    double advance,
  ) {
    if (paymentDate == null || advance == 0) return 0;

    // لو الدفع قبل أو يوم الاستحقاق → لا عقوبة
    if (!paymentDate.isAfter(dueDate)) return 0;

    int monthsLate =
        (paymentDate.year - dueDate.year) * 12 +
        (paymentDate.month - dueDate.month);

    // نسبة العقوبة حسب الشهر
    double percent;
    if (monthsLate == 0) {
      percent = 0.10;
    } else if (monthsLate == 1) {
      percent = 0.20;
    } else if (monthsLate == 2) {
      percent = 0.25;
    } else {
      percent = 0.25;
    }

    double percent2;
    if (monthsLate == 0) {
      percent2 = 250000;
    } else if (monthsLate == 1) {
      percent2 = 500000;
    } else if (monthsLate == 2) {
      percent2 = 1000000;
    } else {
      percent2 = 1000000;
    }

    return advance > 0 ? advance * percent : percent2;
  }

  void calculateTax() {
    if (production.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        construction.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty &&
        otherActivity.text.replaceAll(RegExp(r'[^0-9]'), '').isEmpty) {
      return showSnackbar(
        "خطأ".tr,
        "لا يمكن ان تكون كل قيم النتيجة الجبائية فارغة".tr,
        Colors.red,
      );
    }
    bool hasError = validateAllFields(isFullValidation: true);
    if (hasError) {
      update();
      return;
    }
    productions =
        double.tryParse(production.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    constructions =
        double.tryParse(construction.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;
    other =
        double.tryParse(otherActivity.text.replaceAll(RegExp(r'[^0-9]'), '')) ??
        0;

    double taxProduction = productions * 0.19;
    double taxConstruction = constructions * 0.23;
    double taxOther = other * 0.26;

    double totalTax = taxProduction + taxConstruction + taxOther;
    double totalAdvance = (advance1 ?? 0) + (advance2 ?? 0) + (advance3 ?? 0);
    final year = int.parse(dataTax.text);
    final dueDate1 = DateTime(year, 3, 20);
    final dueDate2 = DateTime(year, 6, 20);
    final dueDate3 = DateTime(year, 11, 20);
    final dueDatefinal = DateTime(year, 5, 1);

    final paymentDate1 = parseDate(advance1Date.text);
    final paymentDate2 = parseDate(advance2Date.text);
    final paymentDate3 = parseDate(advance3Date.text);
    final paymentDatefinal = parseDate(finalPaymentDate.text);

    print("================advance3Date ${advance3Date.text}");
    print("================paymentDate3 $paymentDate3");

    netTax = totalTax - totalAdvance;
    penalty1 = calculatePenalty(paymentDate1, dueDate1, advance1 ?? 0);
    penalty2 = calculatePenalty(paymentDate2, dueDate2, advance2 ?? 0);
    penalty3 = calculatePenalty(paymentDate3, dueDate3, advance3 ?? 0);

    penaltyfinal = finalcalculatePenalty(
      paymentDatefinal,
      dueDatefinal,
      netTax,
    );
    Get.to(PenaltyDetailsScreen());
    print("================netTax $netTax");
    print("================penalty1 $penalty1");
    print("================penalty2 $penalty2");
    print("================penalty3 $penalty3");
    print("================penaltyfinal $penaltyfinal");
    total = total = netTax + penalty1 + penalty2 + penalty3 + penaltyfinal;
    update();
  }

  void calculateTaxperson1() {
    bool hasError = validateAllFields(isFullValidation: false);
    if (hasError) {
      update();
      return;
    }
    productions =
        double.tryParse(production.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    final dueDate1 = DateTime(DateTime.now().year, 3, 20);
    final dueDate2 = DateTime(DateTime.now().year, 6, 20);
    final dueDatefinal = DateTime(DateTime.now().year, 5, 1);

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

    final paymentDate1 = parseDate(advance1Date.text);
    final paymentDate2 = parseDate(advance2Date.text);
    final paymentDatefinal = parseDate(finalPaymentDate.text);
    netTax = calculateProgressiveTax(productions);
    penalty1 = calculatePenalty(paymentDate1, dueDate1, advance1 ?? 0);
    penalty2 = calculatePenalty(paymentDate2, dueDate2, advance2 ?? 0);

    penaltyfinal = finalcalculatePenalty(
      paymentDatefinal,
      dueDatefinal,
      netTax,
    );
    Get.to(PenaltyDetailsScreen());
    print("================netTax $netTax");
    print("================penalty1 $penalty1");
    print("================penalty2 $penalty2");
    print("================penaltyfinal $penaltyfinal");
    type == 2
        ? total = netTax + penalty1 + penalty2 + penaltyfinal
        : total = netTax + penaltyfinal;
  }

  // 🔹 الرجوع من CreateACompany
  void backFromCreateCompany() {
    dataCreate.clear();
    dataCreateErorr = null;
    Get.back();
  }

  // 🔹 الرجوع من TxsLastyear
  void backFromLastYear() {
    TaxLastyear.clear();
    surplus.clear();
    taxLastyearErorr = null;
    surplusErorr = null;
    Get.back();
  }

  // 🔹 الرجوع من Capital
  void backFromCapital() {
    capital.clear();
    capitalErorr = null;
    Get.back();
  }

  // 🔹 الرجوع من TaxPrepaymentsPage
  void backFromPrepayments() {
    advance1 = 0;
    advance2 = 0;
    advance3 = 0;

    Get.back();
  }

  // 🔹 الرجوع من Taxinputpage
  void backFromTaxInput() {
    production.clear();
    construction.clear();
    otherActivity.clear();
    finalPaymentDate.clear();
    dataTax.clear();
    advance1Date.clear();
    advance2Date.clear();
    advance3Date.clear();
    productionErorr = null;
    otherActivityErorr = null;
    constructionErorr = null;
    advance1DateErorr = null;
    advance2DateErorr = null;
    advance3DateErorr = null;
    finalPaymentDateErorr = null;
    Get.back();
  }

  // 🔹 الرجوع من PenaltyDetailsScreen
  void backFromPenaltyDetails() {
    penalty1 = 0;
    penalty2 = 0;
    penalty3 = 0;
    penaltyfinal = 0;
    netTax = 0;
    Get.back();
  }

  void resetAll() {
    personType = 0;
    type = 0;
    TaxLastyear.clear();
    dataCreate.clear();
    surplus.clear();
    capital.clear();
    production.clear();
    construction.clear();
    otherActivity.clear();
    advance1Date.clear();
    advance2Date.clear();
    advance3Date.clear();
    finalPaymentDate.clear();
    dataTax.clear();
    advance1 = 0;
    advance2 = 0;
    advance3 = 0;
    penalty1 = 0;
    penalty2 = 0;
    penalty3 = 0;
    penaltyfinal = 0;
    netTax = 0;
    surplusLeft = 0;
    productionErorr = null;
    otherActivityErorr = null;
    constructionErorr = null;
    advance1DateErorr = null;
    advance2DateErorr = null;
    advance3DateErorr = null;
    finalPaymentDateErorr = null;
    capitalErorr = null;
    dataCreateErorr = null;
    taxLastyearErorr = null;
    surplusErorr = null;
    dataCreateErorr = null;

    Get.until((route) => Get.currentRoute == fromPage);

    update();
  }

  void backFromCreateReqord() {
    dataCreate.clear();
    dataCreateErorr = null;
    Get.back();
  }

  bool validateAllFields({required bool isFullValidation}) {
    bool hasError = false;

    // ======= تواريخ =======

    if (isFullValidation || type != 3) {
      advance1DateErorr = validInput(advance1Date.text, 20, 3, "Text".tr);
    } else {
      advance1DateErorr = null;
    }

    if (isFullValidation || type != 3) {
      advance2DateErorr = validInput(advance2Date.text, 20, 3, "Text".tr);
    } else {
      advance2DateErorr = null;
    }

    if (isFullValidation) {
      advance3DateErorr = validInput(advance3Date.text, 20, 3, "Text".tr);
    } else {
      advance3DateErorr = null;
    }

    finalPaymentDateErorr = validInput(finalPaymentDate.text, 20, 3, "Text".tr);
    dataTaxErorr = validInput(dataTax.text, 20, 3, "Text".tr);

    if (advance1DateErorr != null ||
        advance2DateErorr != null ||
        advance3DateErorr != null ||
        finalPaymentDateErorr != null) {
      hasError = true;
    }

    // ======= الحقول المالية =======

    final fields = [
      {
        'controller': production,
        'setter': (String? val) => productionErorr = val,
      },
      if (isFullValidation) ...[
        {
          'controller': construction,
          'setter': (String? val) => constructionErorr = val,
        },
        {
          'controller': otherActivity,
          'setter': (String? val) => otherActivityErorr = val,
        },
      ],
    ];

    for (var field in fields) {
      String text = (field['controller'] as TextEditingController).text
          .replaceAll(RegExp(r'[^0-9]'), '')
          .trim();

      if (text.isNotEmpty || personType == 1) {
        String? error = validInput(text, 20, 4, "int".tr);
        (field['setter'] as Function)(error);

        if (error != null) hasError = true;
      } else {
        (field['setter'] as Function)(null);
      }
    }
    update();
    return hasError;
  }

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
