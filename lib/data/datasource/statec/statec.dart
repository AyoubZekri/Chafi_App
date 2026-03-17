import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/model/InstitutionTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/HomeController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../core/constant/imageassets.DART';
import '../../../core/services/Services.dart';
import '../../model/CardServicesModel.dart';
import '../../model/onbardingmodel.dart';

Myservices myServices = Get.find();
bool get isLoggedIn => myServices.sharedPreferences?.getString("token") != null;

void handleLoginRequired(void Function() onSuccess) {
  if (!isLoggedIn) {
    Get.defaultDialog(
      title: "تنبيه",
      middleText: "يجب عليك تسجيل الدخول أولاً",
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColor.typography,
      ),
      middleTextStyle: const TextStyle(fontSize: 14, color: Color(0xFF566573)),
      radius: 15,
      textCancel: "إلغاء",
      cancelTextColor: AppColor.typography,
      textConfirm: "تسجيل الدخول",
      confirmTextColor: AppColor.white,
      buttonColor: AppColor.typography,
      onConfirm: () {
        Get.back();
        Get.find<HomecontrollerImp>().onClose();
        Get.toNamed(Approutes.googleSignIn);
      },
    );
    return;
  }
  onSuccess();
}

List<AppOnbardingmodel> onBardinglist = [
  AppOnbardingmodel(
    title: "4".tr,
    body: "5".tr,
    image: Appimageassets.onBardinImageone,
  ),
  AppOnbardingmodel(
    title: "6".tr,
    body: "7".tr,
    image: Appimageassets.onBardinImagetwo,
  ),
  AppOnbardingmodel(
    title: "8".tr,
    body: "9".tr,
    image: Appimageassets.onBardinImagethree,
  ),
];

List<Cardservicesmodel> Cardservices = [
  Cardservicesmodel(
    title: "25",
    image: Appimageassets.records,
    color: const Color(0xFF2563EB), // Blue
    color2: const Color(0xFF1E40AF),
    onTap: () {
      Get.toNamed(Approutes.institutionfield);
    },
  ),

  Cardservicesmodel(
    title: "26",
    image: Appimageassets.tax,
    color: const Color(0xFF7C3AED), // Violet
    color2: const Color(0xFF4C1D95),
    onTap: () {
      Get.toNamed(Approutes.taxsystemstype);
    },
  ),

  Cardservicesmodel(
    title: "29",
    image: Appimageassets.app,
    color: const Color(0xFF4F46E5), // Indigo
    color2: const Color(0xFF3730A3),
    onTap: () {
      Get.toNamed(Approutes.appsystemstype);
    },
  ),

  Cardservicesmodel(
    title: "30",
    image: Appimageassets.shuffle,
    color: const Color(0xFF0EA5E9), // Sky
    color2: const Color(0xFF0369A1),
    onTap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 30, "type": 10, "type_deff": 3},
      );
    },
  ),

  Cardservicesmodel(
    title: "92",
    image: Appimageassets.conditions,
    color: const Color(0xFFF59E0B),
    color2: const Color(0xFFB45309),
    onTap: () {
      Get.toNamed(Approutes.obligations);
    },
  ),

  Cardservicesmodel(
    title: "93",
    image: Appimageassets.questions,
    color: const Color(0xFF10B981),
    color2: const Color(0xFF065F46),
    onTap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 93, "type": 10, "type_deff": 1},
      );
    },
  ),

  Cardservicesmodel(
    title: "27",
    image: Appimageassets.rejester,
    color: const Color(0xFF14B8A6),
    color2: const Color(0xFF0F766E),
    onTap: () {
      Get.toNamed(Approutes.persontype);
    },
  ),

  Cardservicesmodel(
    title: "28",
    image: Appimageassets.calcel,
    color: Color(0xff34C759),
    color2: Color(0xff19612B),
    onTap: () {
      Get.toNamed(Approutes.calculators);
    },
  ),
];

List<Institutiontypemodel> institutionfild = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.institutiontype);
    },
    body: "31",
    imgae: Appimageassets.oneCard,
    color1: Color(0xff164573),
    color2: Color(0xff473BF0),
    sizeText: 36,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.regulatedinstitutiontypes);
    },
    body: "32",
    imgae: Appimageassets.towCard,
    color1: Color(0xff82BE42),
    color2: Color(0xff3C581F),
    sizeText: 32,
  ),
];

List<Institutiontypemodel> institutionType = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 33, "type": 1},
      );
    },
    body: "33",
    imgae: Appimageassets.threeCard,
    color1: Color.fromARGB(187, 22, 68, 115),
    color2: Color.fromARGB(187, 22, 68, 115),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 34, "type": 2},
      );
    },
    body: "34",
    imgae: Appimageassets.fourCard,
    color1: Color.fromARGB(235, 22, 68, 115),
    color2: Color.fromARGB(235, 22, 68, 115),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 35, "type": 3},
      );
    },
    body: "35",
    imgae: Appimageassets.fiveCard,
    color1: Color.fromARGB(235, 22, 68, 115),
    color2: Color.fromARGB(235, 22, 68, 115),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 36, "type": 4},
      );
    },
    body: "36",
    imgae: Appimageassets.sexCard,
    color1: Color(0xff164573),
    color2: Color(0xff164573),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> regulatedInstitutionTypes = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 37, "type": 5},
      );
    },
    body: "37",
    imgae: Appimageassets.savenCard,
    color1: Color(0xff3C581F),
    color2: Color(0xff82BE42),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 38, "type": 6},
      );
    },
    body: "38",
    imgae: Appimageassets.eightCard,
    color1: Color(0xff3C581F),
    color2: Color(0xff82BE42),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 39, "type": 7},
      );
    },
    body: "39",
    imgae: Appimageassets.nineCard,
    color1: Color(0xff3C581F),
    color2: Color(0xff82BE42),
    sizeText: Get.locale == Locale("fr") ? 18 : 24,
  ),
];

List<Institutiontypemodel> taxsystemstype = [
  Institutiontypemodel(
    ontap: () {
      print("===========");
      Get.toNamed(
        Approutes.categoriesTax,
        arguments: {"name": 49, "tax_id": 0},
      );
    },
    body: "49",
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.categoriesTax,
        arguments: {"name": 50, "tax_id": 1},
      );
    },
    body: "50",
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.categoriesTax,
        arguments: {"name": 48, "tax_id": 2},
      );
    },
    body: "48",
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> taxsystemstypeapp = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.categoriesapp,
        arguments: {"name": 29, "tax_id": 0},
      );
    },
    body: "49",
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.categoriesapp,
        arguments: {"name": 29, "tax_id": 1},
      );
    },
    body: "50",
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.categoriesapp,
        arguments: {"name": 29, "tax_id": 2},
      );
    },
    body: "48",
    imgae: Appimageassets.tenCard,
    color1: Color(0xff4F46E5),
    color2: Color(0xff8B5CF6),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> obligationstype = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"tax_id": 0});
    },
    body: "49",
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"tax_id": 1});
    },
    body: "50",
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"tax_id": 2});
    },
    body: "48",
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> calculators = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.calculatorsofSystemSimpli);
    },
    body: "49",
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.calculatorsarbitrarysystem);
    },
    body: "50",
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.calculatorsrealsystem,
        arguments: {"name": 48, "tax_id": 2},
      );
    },
    body: "48",
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),

  Institutiontypemodel(
    ontap: () {
      Get.toNamed(
        Approutes.calculatorsdefferent,
        arguments: {"name": 30, "tax_id": 2},
      );
    },
    body: "30",
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> calculatorsofSystemSimpli = [
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.calactivityType,
        arguments: {'fromPage': "/calculatorsofSystemSimpli"},
      ),
    ),
    body: "حاسبة G12",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 27,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.typeacteviteg12bes,
        arguments: {'fromPage': "/calculatorsofSystemSimpli"},
      ),
    ),

    body: "حاسبة G12BES",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 27,
  ),
];

List<Institutiontypemodel> calculatorsofSystemarbitrary = [
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.taxstamp,
        arguments: {'fromPage': "/Calculatorsarbitrarysystem"},
      ),
    ),

    body: "الطابع الجبائي",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
];

List<Institutiontypemodel> calculatorsofSystemarreal = [
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.calPersontype,
        arguments: {'fromPage': "/Calculatorsrealsystem"},
      ),
    ),

    body: "حاسبة النظام الحقيقي",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 20,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.lossORprofit,
        arguments: {'fromPage': "/Calculatorsrealsystem"},
      ),
    ),

    body: "كشف التلخيص السنوي",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 20,
  ),

  Institutiontypemodel(
    ontap: () {
      handleLoginRequired(
        () => Get.toNamed(
          Approutes.taxstamp,
          arguments: {'fromPage': "/Calculatorsrealsystem"},
        ),
      );
    },
    body: "الطابع الجبائي",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
];

List<Institutiontypemodel> calculatorsofDiffernt = [
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.inputdata,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "budget_deposit",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.costsguidance,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "gifts",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.advertisingandsponsorship,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "advertising_sponsorship",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.toueisttype,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "المركبات السياحية",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.researchanddevelopment,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "البحث والتطوير",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.realestateincometype,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "المداخيل العقارية",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.surrenderofthepropertytype,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "التنازل عن العقارات",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.waiverofinvestmentvalue,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "التنازل عن الإستثمار",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),

  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.accounttype,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "bonuses_compensation",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
  Institutiontypemodel(
    ontap: () => handleLoginRequired(
      () => Get.toNamed(
        Approutes.taxtype,
        arguments: {'fromPage': "/Calculatorsdefferent"},
      ),
    ),

    body: "ضريبة الفوائد",
    imgae: Appimageassets.calculators,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 25,
  ),
];
