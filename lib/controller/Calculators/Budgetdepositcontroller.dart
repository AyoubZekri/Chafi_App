import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/functions/trundatefromStringtodate.dart';
import '../../core/functions/valiedinput.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../view/screen/Calculators/different/BudgetDeposit/ShwoditailsBudgetDeposit.dart';

class Budgetdepositcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  String? fromPage;
  String? budgetdepositErorr;
  String? datedepositErorr;
  String? datepymentErorr;
  String? datebudgetdepositErorr;

  TextEditingController datebudgetdeposit = TextEditingController();
  TextEditingController budgetdeposit = TextEditingController();
  TextEditingController datedeposit = TextEditingController();
  TextEditingController datepyment = TextEditingController();

  double netTax = 0;
  double budgetdeposits = 0;
  double deposit = 0;
  double pyment = 0;
  double paymentPenalty = 0;

  double calculateDepositPenalty(
    DateTime baseDate,
    DateTime depositDate,
    double amount,
  ) {
    DateTime delayStart = DateTime(baseDate.year, baseDate.month + 1, 21);

    if (depositDate.isBefore(delayStart)) {
      return 0;
    }

    // نفس الشهر بعد 21
    if (depositDate.year == delayStart.year &&
        depositDate.month == delayStart.month) {
      return amount * 0.05;
    }

    // من الشهر اللي بعده
    return amount * 0.10;
  }

  double calculateThreatPenalty(
    DateTime baseDate,
    DateTime depositDate,
    double amount,
  ) {
    DateTime delayStart = DateTime(baseDate.year, baseDate.month + 1, 21);

    if (depositDate.isBefore(delayStart)) {
      return 0;
    }

    // فرق الأشهر من شهر بداية التأخير
    int monthsLate =
        (depositDate.year - delayStart.year) * 12 +
        (depositDate.month - delayStart.month);

    if (monthsLate < 1) {
      return 0; // الشهر الأول ما فيهش تهديدية
    }

    int extraMonths = monthsLate;

    if (extraMonths > 5) {
      extraMonths = 5;
    }

    // 10% ثابتة + 3% لكل شهر
    return amount * (0.03 * extraMonths);
  }

  double calculatePaymentPenalty(
    DateTime baseDate,
    DateTime paymentDate,
    double amount,
  ) {
    DateTime delayStart = DateTime(baseDate.year, baseDate.month + 1, 21);

    if (paymentDate.isBefore(delayStart)) {
      return 0;
    }

    return amount * 0.10; // 10% ثابتة
  }

  double calculateTotal(
    double amount,
    double depositPenalty,
    double threatPenalty,
  ) {
    return amount + depositPenalty + threatPenalty;
  }

  void calcul() {
    if (validateAllFields()) return;

    String cleanBudget = budgetdeposit.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanBudget.isEmpty) return;

    double amount = double.parse(cleanBudget);

    final baseDate = parseDate(datebudgetdeposit.text);

    final depositDate = parseDate(datedeposit.text);

    final paymentDate = parseDate(datepyment.text);

    deposit = calculateDepositPenalty(baseDate!, depositDate!, amount);

    pyment = calculateThreatPenalty(baseDate, depositDate, amount);

    paymentPenalty = calculatePaymentPenalty(baseDate, paymentDate!, amount);
    print(deposit);
    print(pyment);
    print(paymentPenalty);

    netTax = deposit + pyment + paymentPenalty;
    Get.to(Shwoditailsbudgetdeposit());
    update();
  }

  void Back() {
    budgetdeposit.clear();
    budgetdepositErorr = null;
    datedeposit.clear();
    datebudgetdeposit.clear();
    datebudgetdepositErorr = null;
    datedepositErorr = null;
    datepyment.clear();
    datepymentErorr = null;
    netTax = 0;
    pyment = 0;
    deposit = 0;
    paymentPenalty = 0;
    update();
    Get.back();
  }

  void resetAll() {
    budgetdeposit.clear();
    budgetdepositErorr = null;
    datedeposit.clear();
    datebudgetdeposit.clear();
    datebudgetdepositErorr = null;
    datedepositErorr = null;
    datepyment.clear();
    datepymentErorr = null;
    netTax = 0;
    pyment = 0;
    deposit = 0;
    paymentPenalty = 0;
    update();
    Get.until((route) => Get.currentRoute == fromPage);
  }

  bool validateAllFields() {
    bool hasError = false;

    budgetdepositErorr = validInput(
      budgetdeposit.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      4,
      "int",
    );
    if (budgetdepositErorr != null) hasError = true;

    if (datedeposit.text.isEmpty) {
      datedepositErorr = "تاريخ الإيداع مطلوب".tr;
      hasError = true;
    } else {
      datedepositErorr = validInput(datedeposit.text, 20, 3, "Text");
      if (datedepositErorr != null) hasError = true;
    }

    if (datepyment.text.isEmpty) {
      datepymentErorr = "تاريخ الدفع مطلوب";
      hasError = true;
    } else {
      datepymentErorr = validInput(datepyment.text, 20, 4, "Text");
      if (datepymentErorr != null) hasError = true;
    }

    if (datebudgetdeposit.text.isEmpty) {
      datebudgetdepositErorr = "تاريخ الميزانية مطلوب".tr;
      hasError = true;
    } else {
      datebudgetdepositErorr = validInput(
        datebudgetdeposit.text,
        20,
        3,
        "Text",
      );
      if (datebudgetdepositErorr != null) hasError = true;
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
}
