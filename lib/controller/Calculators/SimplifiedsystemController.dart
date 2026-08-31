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
import 'package:chafi/core/class/Statusrequest.dart';
import 'package:chafi/core/functions/CheckInternat.dart';
import 'package:chafi/core/functions/handlingdatacontroller.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:chafi/data/datasource/Remote/PostData.dart';
import 'package:chafi/core/constant/Colorapp.dart';

class Simplifiedsystemcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
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
  int exemptAdvancesCount = 0;

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
    dataTaxErorr = validInput(dataTax.text, 20, 3, "Text".tr);
    if (dataCreateErorr != null || dataTaxErorr != null) {
      update();
      return;
    }
    final yearStr = dataCreate.text.substring(0, 4);
    final year = int.tryParse(yearStr);
    final taxYear = int.tryParse(dataTax.text);

    print("==============$year");
    print("===============$taxYear");

    if (year != null && taxYear != null && year > taxYear) {
      showSnackbar(
        "تنبيه",
        "لا يمكن ان تكون سنة التصريح اقدم من سنة الانشاء",
        Colors.orange,
      );
      return;
    }

    if (year == taxYear && personType == 2) {
      type = 1; // شركة في عامها الاول
      Get.to(Capital());
    } else if (year != null && taxYear != null && year < taxYear) {
      type = 2; // شركة او مؤسسة بعد عامها الاول
      Get.to(Txslastyear());
    } else if (year == taxYear && personType == 1) {
      type = 3; // مؤسسة في عامها الاول
      _showModernInfoDialog(
        title: "تنبيه هام".tr,
        message: "معفى من التسبيق الأول والثاني حسب النظام الجبائي".tr,
        onConfirm: () {
          Get.to(Taxinpout());
        },
      );
    }
    update();
  }

  void divideTaxToAdvance() {
    taxLastyearErorr = validInput(
      TaxLastyear.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "Text",
    );
    dataTaxErorr = validInput(dataTax.text, 20, 3, "Text".tr);

    surplusErorr = validInput(
      surplus.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "Text",
      empty: true,
    );
    if (taxLastyearErorr != null ||
        surplusErorr != null ||
        dataTaxErorr != null) {
      update();
      return;
    }
    double? tax = double.tryParse(
      TaxLastyear.text.replaceAll(RegExp(r'[^0-9]'), ''),
    );
    double? remainingSurplus =
        double.tryParse(surplus.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0.0;

    if (tax == null) {
      Get.snackbar(
        "خطأ".tr,
        "الرجاء إدخال أرقام صحيحة للضريبة".tr,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    List<double> advances = personType == 1
        ? [0.3, 0.3].map((p) => tax * p).toList()
        : [0.3, 0.3, 0.3].map((p) => tax * p).toList();
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

    advance1 = advances.isNotEmpty ? advances[0] : 0;
    advance2 = advances.length > 1 ? advances[1] : 0;
    advance3 = advances.length > 2 ? advances[2] : 0;

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
    taxValue = taxValue * 0.05;
    advance1 = taxValue * 0.3;
    advance2 = taxValue * 0.3;
    advance3 = taxValue * 0.3;

    print("التسبيق 1: $advance1");
    print("التسبيق 2: $advance2");
    print("التسبيق 3: $advance3");

    exemptAdvancesCount = 0;
    int year = int.tryParse(dataCreate.text.substring(0, 4)) ?? 0;
    int taxYear = int.tryParse(dataTax.text) ?? 0;

    if (year == taxYear) {
      DateTime? creationDate = parseDate(dataCreate.text);
      if (creationDate != null) {
        DateTime march20 = DateTime(year, 3, 20);
        DateTime june20 = DateTime(year, 6, 20);
        DateTime nov20 = DateTime(year, 11, 20);

        if (creationDate.isAfter(nov20)) {
          exemptAdvancesCount = 3;
        } else if (creationDate.isAfter(june20)) {
          exemptAdvancesCount = 2;
        } else if (creationDate.isAfter(march20)) {
          exemptAdvancesCount = 1;
        }
      }
    }

    if (exemptAdvancesCount == 3) {
      _showModernInfoDialog(
        title: "تنبيه هام".tr,
        message:
            "أنت معفى من جميع التسبيقات (الأول، الثاني، والثالث) حسب تاريخ الإنشاء"
                .tr,
        onConfirm: () {
          gotoDetective();
        },
      );
    } else if (exemptAdvancesCount > 0) {
      String msg = exemptAdvancesCount == 2
          ? "أنت معفى من التسبيق الأول والثاني حسب تاريخ الإنشاء".tr
          : "أنت معفى من التسبيق الأول حسب تاريخ الإنشاء".tr;

      _showModernInfoDialog(
        title: "تنبيه هام".tr,
        message: msg,
        onConfirm: () {
          Get.to(TaxPrepaymentsPage());
        },
      );
    } else {
      Get.to(TaxPrepaymentsPage());
    }
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
    final dueDatefinal = type == 3
        ? DateTime(int.parse(dataTax.text) + 1, 5, 1)
        : DateTime(DateTime.now().year, 5, 1);

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
    dataTax.clear();
    dataTaxErorr = null;
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

  // 🔹 Custom Dialog for First Year Exemption
  void _showModernInfoDialog({
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.typography,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Color(0xFF475569),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        foregroundColor: AppColor.typography,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "إلغاء".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.typography,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        onConfirm();
                      },
                      child: Text(
                        "تأكيد".tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
