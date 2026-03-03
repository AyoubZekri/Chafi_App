import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/trundatefromStringtodate.dart';
import '../../view/screen/Calculators/different/BudgetDeposit/ShwoditailsBudgetDeposit.dart';

class Budgetdepositcontroller extends GetxController {
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

  @override
  void onInit() {
    fromPage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }
}
