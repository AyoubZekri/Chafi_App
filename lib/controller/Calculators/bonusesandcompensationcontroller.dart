import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/CheckInternat.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../data/datasource/Remote/bonusesandcompensations.dart';
import '../../data/model/BonusModel.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/AccountType.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/BonusesTaxable.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/ShowValuo.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/bonuses_and_compensations.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/inboutvalou.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/non_taxable_non_contributory.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/Absentdays.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/personscondition.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/speciallogictype.dart';

class bonusesandcompensationcontroller extends GetxController {
  Postdata postdata = Postdata(Get.find());
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  int typeAccount = 1;
  int personscondition = 0;
  int hasspeciallogictype = 0;
  String? fixedValueControllerError;
  String? hasspeciallogicError;
  String? numdayError;
  String? baseWorkingDaysError;
  String? absentDaysError;
  String? frompage;

  Bonusesandcompensation bonusesandcompensation = Bonusesandcompensation(
    Get.find(),
  );
  TextEditingController fixedValueController = TextEditingController();
  TextEditingController hasspeciallogic = TextEditingController();
  TextEditingController numday = TextEditingController();
  TextEditingController baseWorkingDaysController = TextEditingController();
  TextEditingController absentDaysController = TextEditingController();
  Map<int, RxSet<int>> selectedGroups = {
    1: <int>{}.obs,
    2: <int>{}.obs,
    3: <int>{}.obs,
  };

  Map<int, Map<int, TextEditingController>> valueControllersGroups = {
    1: {},
    2: {},
    3: {},
  };

  Map<int, Map<int, String?>> bonusErrorsGroups = {1: {}, 2: {}, 3: {}};

  List<BonusModel> data = [];
  Map<int, List<BonusModel>> groupedData = {};
  double Basicwage = 0;
  double Basicwage0_7 = 0;
  double sumgroub1 = 0;
  double sumgroub2 = 0;
  double sumgroub3 = 0;
  double person9 = 0;
  double zoon = 0;
  double grossincome = 0;
  double iRG = 0;
  double discount40 = 0;
  double discount1 = 0;
  double discount2 = 0;
  double total = 0;
  double totalBonusDeductions = 0;
  bool isCacobatph = false;
  double cacobatphAmount = 0;

  void selectedCacobatph(bool value) {
    isCacobatph = value;
    update();
  }

  void gotoAccountType() {
    print("isCacobatph =============== $isCacobatph");
    Get.to(() => Accounttype(), preventDuplicates: false);
  }

  void selectedtypeAccount(int i) {
    typeAccount = i;
    update();
  }

  void gotoAbsentDays() {
    baseWorkingDaysError = validInput(
      baseWorkingDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      2,
      1,
      "int",
    );
    if (baseWorkingDaysError != null) {
      update();
      return;
    }
    Get.to(() => Absentdays());
  }

  void gotoPersonscondition() {
    absentDaysError = validInput(
      absentDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      2,
      0,
      "int",
    );
    if (absentDaysError != null) {
      update();
      return;
    }

    int baseDays =
        int.tryParse(
          baseWorkingDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    int absDays =
        int.tryParse(
          absentDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    int workedDays = baseDays - absDays;
    if (workedDays < 0) workedDays = 0;
    Get.to(() => Personscondition());
  }

  void selectedpersonscondition(int i) {
    personscondition = i;
    update();
  }

  void gotoSpeciallogictype() {
    print("===============$personscondition");
    if (personscondition == 0) {
      return showSnackbar(
        "خطأ".tr,
        "الرجاء اختيار نوع الشخص إذا كنت تنتمي إلى هؤلاء الأشخاص، أو اختر 'لست منهم'."
            .tr,
        Colors.red,
      );
    }
    Get.to(() => Speciallogictype());
  }

  void selectedhasspeciallogictype(int i) {
    hasspeciallogictype = i;
    update();
  }

  void gotobonusesandcompensations() {
    print("===============$personscondition");
    if (hasspeciallogictype == 0) {
      return showSnackbar("خطأ".tr, "يجب إختيار علاوة المنطقة".tr, Colors.red);
    }
    Get.to(() => BonusesAndCompensations());
  }

  void togglegroup(int id, bool value, int cat) {
    print(id);
    print(value);
    print(cat);

    final targetSet = selectedGroups[cat];
    final targetControllers = valueControllersGroups[cat];

    if (targetSet == null || targetControllers == null) return;

    if (value) {
      targetSet.add(id);

      if (!targetControllers.containsKey(id)) {
        targetControllers[id] = TextEditingController();
      }
    } else {
      targetSet.remove(id);
      targetControllers[id]?.dispose();
      targetControllers.remove(id);
    }

    update();
  }

  void gotoBonusestaxable() {
    Get.to(() => Bonusestaxable());
  }

  void gotoNonTaxableNonContributory() {
    Get.to(() => NonTaxableNonContributory());
  }

  void gotoInboutvalou() {
    Get.to(() => Inboutvalou());
  }

  void calcul() {
    if (validateAllCategories()) {
      calculateGroupsSum();
      person9 = sumgroub1 * 0.09;
      if (isCacobatph) {
        cacobatphAmount = sumgroub1 * 0.00375;
      } else {
        cacobatphAmount = 0;
      }
      // The exempt amount is now in sumgroub3, so it is naturally excluded from grossincome.
      grossincome = (sumgroub1 + sumgroub2) - person9 - cacobatphAmount;
      total = sumgroub1 + sumgroub2 + sumgroub3;
      print("total $total");
      print("person9 $person9");
      print("grossincome $grossincome");
      print("zoon $zoon");
      print("typeAccount $typeAccount");
      print("personscondition $personscondition");
      if (grossincome >= 3000000) {
        if (typeAccount == 1) {
          iRG = iRGMOUTH(grossincome);
          discount40 = iRG * 0.4;
          print("==============iRG $iRG");
          print("==============discount40 $discount40");
          double reduction = discount40;

          if (reduction <= 150000 && reduction >= 100000) {
            discount1 = iRG - reduction;
          }
          if (discount1 < 0) discount1 = 0;
          discount1 = discount1 / 100;
          if (3000000 <= grossincome &&
              grossincome <= 3500000 &&
              personscondition == 6) {
            discount2 = (discount1 * (137 / 51)) - (27925 / 8);
            discount2 = discount2 * 100;
            print("==============discount1 $discount1");
            print("==============discount---2 $discount2");
          } else if (3000000 <= grossincome &&
              grossincome <= 4250000 &&
              personscondition != 6) {
            discount2 = discount1 * (61 / 93) - (41 / 81.213);
            discount2 = discount2 * 100;
          } else {
            discount2 = discount1;
            discount2 = discount2 * 100;
          }
        } else {
          iRG = iRGYARE(grossincome);
          discount40 = iRG * 0.4;

          double reduction = discount40;
          if (reduction < (100000 * 12)) reduction = (100000 * 12);
          if (reduction > (150000 * 12)) reduction = (150000 * 12);

          discount1 = iRG - reduction;
          if (discount1 < 0) discount1 = 0;

          if ((3000000 * 12) <= grossincome &&
              grossincome <= (3500000 * 12) &&
              personscondition == 6) {
            discount2 = discount1 * (51 / 137) - (8 / 27925);
          } else if ((3000000 * 12) <= grossincome &&
              grossincome <= (4250000 * 12) &&
              personscondition != 6) {
            discount2 = discount1 * (61 / 93) - (41 / 81.213);
          } else {
            discount2 = discount1;
          }
        }
      }
      Get.to(() => Showvaluo());
    }
    update();
  }

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await bonusesandcompensation.viewdata();
    print("Response: $response");

    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1) {
        data.clear();
        List listdata = response['data'];
        data.addAll(listdata.map((e) => BonusModel.fromJson(e)));

        for (var bonus in data) {
          if (!groupedData.containsKey(bonus.category)) {
            groupedData[bonus.category] = [];
          }
          groupedData[bonus.category]!.add(bonus);
        }
        if (data.isEmpty) {
          statusrequest = Statusrequest.nodata;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  double iRGYARE(double value) {
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

  double iRGMOUTH(double value) {
    double tax = 0;
    print("==============value $value");
    if (value > 2000000) {
      double taxable = (value > 4000000 ? 4000000 : value) - 2000000;
      tax += taxable * 0.23;
    }

    if (value > 4000000) {
      double taxable = (value > 8000000 ? 8000000 : value) - 4000000;
      tax += taxable * 0.27;
    }

    if (value > 8000000) {
      double taxable = (value > 16000000 ? 16000000 : value) - 8000000;
      tax += taxable * 0.30;
    }

    if (value > 16000000) {
      double taxable = (value > 32000000 ? 32000000 : value) - 16000000;
      tax += taxable * 0.33;
    }

    if (value > 32000000) {
      double taxable = value - 32000000;
      tax += taxable * 0.35;
    }

    if (tax < 100000) {
      return 100000;
    }
    return tax;
  }

  void calculateGroupsSum() {
    sumgroub1 = 0;
    sumgroub2 = 0;
    sumgroub3 = 0;
    totalBonusDeductions = 0;

    int baseDays =
        int.tryParse(
          baseWorkingDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        1;
    if (baseDays == 0) baseDays = 1;

    int absDays =
        int.tryParse(
          absentDaysController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    int actualWorkedDays = baseDays - absDays;
    if (actualWorkedDays < 0) actualWorkedDays = 0;

    Basicwage =
        double.tryParse(
          fixedValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    int nmpdyes =
        int.tryParse(numday.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    Basicwage = (Basicwage / baseDays) * actualWorkedDays;

    double hasspecial =
        double.tryParse(
          hasspeciallogic.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (hasspeciallogictype == 2) {
      double maxExempt = Basicwage * 0.7;
      double totalZoneBonus = nmpdyes * hasspecial;
      if (maxExempt > totalZoneBonus) {
        Basicwage0_7 = totalZoneBonus;
        zoon = 0;
      } else {
        Basicwage0_7 = maxExempt;
        zoon = totalZoneBonus - maxExempt;
      }
    } else {
      zoon = Basicwage * (nmpdyes / 100);
      Basicwage0_7 = 0;
    }
    valueControllersGroups.forEach((cat, controllers) {
      double sum = 0;

      controllers.forEach((id, controller) {
        final value = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        final bonus = data.firstWhereOrNull((e) => e.id == id);
        final isPercentage = bonus?.valueType == 1;

        if (value.isNotEmpty) {
          double val = double.parse(value);
          if (isPercentage) {
            val = Basicwage * (val / 100);
          } else {
            val = (val / baseDays) * actualWorkedDays;
          }
          if (bonus?.actionType == 2) {
            sum -= val;
            totalBonusDeductions += val;
          } else {
            sum += val;
          }
        }
      });

      if (cat == 1) sumgroub1 = sum;
      if (cat == 2) sumgroub2 = sum;
      if (cat == 3) sumgroub3 = sum;
    });

    double exemptAmount = (hasspeciallogictype == 2) ? Basicwage0_7 : zoon;
    sumgroub1 += Basicwage;
    sumgroub2 += (hasspeciallogictype == 2 ? zoon : 0);
    sumgroub3 += exemptAmount;

    update();
  }

  bool validateAllCategories() {
    bool isValid = true;

    // reset errors
    fixedValueControllerError = null;
    numdayError = null;
    hasspeciallogicError = null;

    bonusErrorsGroups.forEach((cat, errors) {
      errors.clear();
    });

    // الأجر القاعدي
    fixedValueControllerError = validInput(
      fixedValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      3,
      "int",
    );
    if (fixedValueControllerError != null) {
      isValid = false;
    }

    numdayError = validInput(
      numday.text.replaceAll(RegExp(r'[^0-9]'), ''),
      20,
      1,
      "int",
    );
    if (numdayError != null) {
      isValid = false;
    }
    // سعر اليوم
    if (hasspeciallogictype == 2) {
      hasspeciallogicError = validInput(
        hasspeciallogic.text.replaceAll(RegExp(r'[^0-9]'), ''),
        20,
        3,
        "int",
      );
      if (hasspeciallogicError != null) {
        isValid = false;
      }
    }

    // تحقق من الثلاث فئات
    valueControllersGroups.forEach((cat, controllers) {
      controllers.forEach((id, textController) {
        final bonus = data.firstWhereOrNull((e) => e.id == id);
        final isPercentage = bonus?.valueType == 1;

        bonusErrorsGroups[cat]?[id] = validInput(
          textController.text.replaceAll(RegExp(r'[^0-9]'), ''),
          20,
          isPercentage ? 1 : 3,
          "int",
        );
        if (bonusErrorsGroups[cat]?[id] != null) {
          isValid = false;
        }
      });
    });

    update();
    return isValid;
  }

  void BackFromAccounttype() {}

  void BackFromAbsentDays() {}

  void BackFromPersonscondition() {
    personscondition = 0;
  }

  void BackFromSpeciallogictype() {
    hasspeciallogictype = 0;
  }

  void BackFromNonTaxableNonContributory() {}
  void BackFromBonusesAndCompensations() {}
  void BackFromBonusestaxable() {}

  void BackFromInboutvalou() {}

  void backFromShowvaluo() {}
  void resetAll() {
    Get.until((route) => Get.currentRoute == frompage);
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
    viewdata();
    frompage = Get.arguments?['fromPage'] ?? '';
    addenter(4);
    super.onInit();
  }
}
