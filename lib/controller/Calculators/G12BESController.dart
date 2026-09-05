import 'package:chafi/view/screen/Calculators/ArbitrarySystem.dart/G12BES/ShwopenaltyG12BES.dart';
import 'package:chafi/view/screen/Calculators/ArbitrarySystem.dart/G12BES/TaxinputdataRecordeG12BES.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/constant/Colorapp.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../view/screen/Calculators/ArbitrarySystem.dart/G12BES/EstablishmentDateG12BES.dart';

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
  String? establishmentYearErorr;

  // أخطاء حقول التقديري للنشاطات 3
  String? g12ProductionErorr;
  String? g12ProfitMarginErorr;
  String? g12OtherActivityErorr;

  int activityType = 0;
  TextEditingController production = TextEditingController();
  TextEditingController g12 = TextEditingController(text: "0");

  // حقول التقديري للنشاطات 3
  TextEditingController g12Production = TextEditingController(text: "0");
  TextEditingController g12ProfitMargin = TextEditingController(text: "0");
  TextEditingController g12OtherActivity = TextEditingController(text: "0");

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
  TextEditingController establishmentYear = TextEditingController();

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

  bool get isFirstYear =>
      establishmentYear.text.isNotEmpty &&
      dataTax.text.isNotEmpty &&
      establishmentYear.text == dataTax.text;

  selectedPerson(int i) {
    activityType = i;
    update();
  }

  void gotodatacreate() {
    if (activityType == 0) {
      return showSnackbar("خطأ".tr, "إختر نوع النشاط أولا".tr, Colors.red);
    }
    Get.to(() => const EstablishmentDateG12BES());
  }

  void validateAndProceedFromEstablishmentDate() {
    establishmentYearErorr = validInput(establishmentYear.text, 4, 4, "int");
    dataTaxErorr = validInput(dataTax.text, 4, 4, "int");

    if (establishmentYearErorr != null || dataTaxErorr != null) {
      update();
      return;
    }

    int estYear = int.tryParse(establishmentYear.text) ?? 0;
    int decYear = int.tryParse(dataTax.text) ?? 0;

    if (decYear < estYear) {
      return showSnackbar(
        "تنبيه".tr,
        "declaration_before_establishment".tr,
        Colors.red,
      );
    }

    Get.to(() => const Taxinputdatarecordeg12bes());
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

    if (isFirstYear) {
      g12b = 0;
    }

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

      if (isFirstYear) {
        g12p = 0;
        g12pm = 0;
        g12o = 0;
      }

      double diffProduction = productions - g12p;
      double diffProfitMargin = profitmargins - g12pm;
      double diffOtherActivity = other - g12o;

      netTax =
          (diffProduction * 0.05) +
          (diffProfitMargin * 0.05) +
          (diffOtherActivity * 0.12);
    } else if (activityType == 1) {
      double diffSelfContractor = selfcontractors - g12b;
      netTax = (diffSelfContractor * 0.005);
    } else if (activityType == 2) {
      double diffExtracted = extractedfromSources - g12b;
      netTax = (diffExtracted * 0.05);
    }

    // انت غير معني بي G12 ومعني فقط بي G12مكرر
    if (isFirstYear) {
      if (activityType == 1) {
        netTax = netTax < 1000000 ? 1000000 : netTax;
      } else {
        netTax = netTax < 3000000 ? 3000000 : netTax;
      }
    }

    if (netTax < 0) {
      _showModernInfoDialog(
        title: "تنبيه".tr,
        message: "tax_settlement".tr,
        onConfirm: () {
          Get.back();
        },
      );
      return;
    }

    final year = int.parse(dataTax.text);
    final dueDatedepositand = DateTime(year + 1, 1, 20);
    final dueDatede = DateTime(year + 1, 1, 20);
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
    Get.back();
  }

  void backFromEstablishmentDate() {
    establishmentYear.clear();
    dataTax.clear();
    establishmentYearErorr = null;
    dataTaxErorr = null;
    update();
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

    g12Erorr = null;
    g12ProductionErorr = null;
    g12ProfitMarginErorr = null;
    g12OtherActivityErorr = null;

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

    if (isFirstYear) {
      g12b = 0;
    }

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

      if (isFirstYear) {
        g12p = 0;
        g12pm = 0;
        g12o = 0;
      }

      double diffProduction = p - g12p;
      print(
        "======================================= diffProduction==$diffProduction",
      );
      double diffProfitMargin = pm - g12pm;
      print(
        "===  ====================================diffProfitMargin==$diffProfitMargin",
      );
      double diffOtherActivity = o - g12o;
      print(
        "======================================= diffOtherActivity==$diffOtherActivity",
      );

      liveNet =
          (diffProduction * 0.05) +
          (diffProfitMargin * 0.05) +
          (diffOtherActivity * 0.12);
      print("======================================liveNet==$liveNet");
    } else if (activityType == 1) {
      double diffSelfContractor = s - g12b;
      liveNet = (diffSelfContractor * 0.005);
    } else if (activityType == 2) {
      double diffExtracted = e - g12b;
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
                      onPressed: onConfirm,
                      child: Text(
                        "موافق".tr,
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
