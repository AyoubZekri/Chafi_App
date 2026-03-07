
import 'package:chafi/core/functions/valiedinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/Snacpar.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/bonusesandcompensations.dart';
import '../../data/model/BonusModel.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/BonusesTaxable.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/ShowValuo.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/bonuses_and_compensations.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/inboutvalou.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/non_taxable_non_contributory.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/personscondition.dart';
import '../../view/screen/Calculators/different/bonusesandcompensation/speciallogictype.dart';

class bonusesandcompensationcontroller extends GetxController {
  int typeAccount = 0;
  int personscondition = 0;
  int hasspeciallogictype = 0;
  String? fixedValueControllerError;
  String? hasspeciallogicError;
  String? numdayError;
  String? frompage;

  Bonusesandcompensation bonusesandcompensation = Bonusesandcompensation(
    Get.find(),
  );
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  TextEditingController fixedValueController = TextEditingController();
  TextEditingController hasspeciallogic = TextEditingController();
  TextEditingController numday = TextEditingController();
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

  void selectedtypeAccount(int i) {
    typeAccount = i;
    update();
  }

  void gotoPersonscondition() {
    print("===============$typeAccount");
    if (typeAccount == 0) {
      return showSnackbar("خطأ".tr, "الرجاء إختيار نوع الحساب".tr, Colors.red);
    }
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
      grossincome = (sumgroub1 + sumgroub2) - person9 - zoon;
      total = sumgroub1 + sumgroub2 + sumgroub3;
      if (grossincome >= 3000000) {
        if (typeAccount == 1) {
          iRG = iRGMOUTH(grossincome);
          discount40 = iRG * 0.4;
          print("=============irg$iRG");
          print(discount40);
          if (100000 <= discount40 && discount40 <= 150000) {
            discount1 = iRG - discount40;
            print("=============discount1$discount1");
          }
          if (3000000 <= grossincome &&
              grossincome <= 3500000 &&
              personscondition == 6) {
            discount2 = discount1 * (51 / 137) - (8 / 27925);
          }
          if (3000000 <= grossincome &&
              grossincome <= 4250000 &&
              personscondition != 6) {
            discount2 = discount1 * (61 / 93) - (41 / 81.213);
          }
        } else {
          iRG = iRGYARE(grossincome);
          discount40 = iRG * 0.4;
          if ((100000 * 12) <= discount40 && discount40 <= (150000 * 12)) {
            discount1 = iRG - discount40;
          }
          if ((3000000 * 12) <= grossincome &&
              grossincome <= (3500000 * 12) &&
              personscondition == 6) {
            discount2 = discount1 * (51 / 137) - (8 / 27925);
          }
          if ((3000000 * 12) <= grossincome &&
              grossincome <= (4250000 * 12) &&
              personscondition != 6) {
            discount2 = discount1 * (61 / 93) - (41 / 81.213);
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
          statusrequest = Statusrequest.failure;
        }
      } else {
        statusrequest = Statusrequest.failure;
      }
    }

    update();
  }

  @override
  void onInit() {
    viewdata();
    frompage = Get.arguments?['fromPage'] ?? '';
    super.onInit();
  }

  double iRGYARE(double value) {
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

  double iRGMOUTH(double value) {
    double tax = 0;

    // الشريحة 1 → 24 بنسبة 0%
    if (value <= 2000000) return 100000;

    // الشريحة 2 → 24 بنسبة 23%
    if (value >= 2000001 && value >= 4000000) {
      tax += 2000000 * 0.23;
      print("==============tax $tax");
    }

    // الشريحة 3 → 48 بنسبة 27%
    if (value >= 4000001 && value >= 8000000) {
      tax += 4000000 * 0.27;
      print("==============tax2 $tax");
    }

    // الشريحة 4 → 96 بنسبة 30%
    if (value >= 8000001 && value >= 16000000) {
      tax += 8000000 * 0.30;
      print("==============tax4 $tax");
    }

    // الشريحة 5 → 192 بنسبة 33%
    if (value >= 16000001 && value >= 32000000) {
      tax += 16000000 * 0.33;
      print("==============tax5 $tax");
    }

    // ما فوق 384 بنسبة 35%
    if (value >= 32000001) {
      value = value - 32000000;
      tax += value * 0.35;
      print("==============valu $value");
      print("==============tax $tax");
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

    Basicwage =
        double.tryParse(
          fixedValueController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    int nmpdyes =
        int.tryParse(numday.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

    double hasspecial =
        double.tryParse(
          hasspeciallogic.text.replaceAll(RegExp(r'[^0-9]'), ''),
        ) ??
        0;
    if (hasspeciallogictype == 2) {
      Basicwage = Basicwage * 0.7;
      zoon = nmpdyes * hasspecial;
      if (Basicwage > zoon) {
        zoon = 0;
      } else {
        zoon = zoon - Basicwage;
      }
    } else {
      zoon = Basicwage * (nmpdyes / 100);
    }
    valueControllersGroups.forEach((cat, controllers) {
      double sum = 0;

      controllers.forEach((id, controller) {
        final value = controller.text.replaceAll(RegExp(r'[^0-9]'), '');

        if (value.isNotEmpty) {
          sum += double.parse(value);
        }
      });

      if (cat == 1) sumgroub1 = sum + Basicwage;
      if (cat == 2) sumgroub2 = sum;
      if (cat == 3) sumgroub3 = sum;
    });

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
      controllers.forEach((id, controller) {
        bonusErrorsGroups[cat]?[id] = validInput(
          controller.text.replaceAll(RegExp(r'[^0-9]'), ''),
          20,
          3,
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
}
