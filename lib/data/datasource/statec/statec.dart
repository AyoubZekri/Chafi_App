import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/data/model/InstitutionTypeModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/imageassets.DART';
import '../../model/CardServicesModel.dart';
import '../../model/onbardingmodel.dart';

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
    title: "25".tr,
    image: Appimageassets.records,
    color: const Color(0xFF2563EB), // Blue
    color2: const Color(0xFF1E40AF),
    onTap: () {
      Get.toNamed(Approutes.institutionfield);
    },
  ),

  Cardservicesmodel(
    title: "26".tr,
    image: Appimageassets.tax,
    color: const Color(0xFF7C3AED), // Violet
    color2: const Color(0xFF4C1D95),
    onTap: () {
      Get.toNamed(Approutes.taxsystemstype);
    },
  ),

  Cardservicesmodel(
    title: "29".tr,
    image: Appimageassets.app,
    color: const Color(0xFF4F46E5), // Indigo
    color2: const Color(0xFF3730A3),
    onTap: () {
      Get.toNamed(Approutes.appsystemstype);
    },
  ),

  Cardservicesmodel(
    title: "30".tr,
    image: Appimageassets.shuffle,
    color: const Color(0xFF0EA5E9), // Sky
    color2: const Color(0xFF0369A1),
    onTap: () {
      Get.toNamed(
        Approutes.institutionsinfo,
        arguments: {"name": 30, "type": 14},
      );
    },
  ),

  Cardservicesmodel(
    title: "92".tr,
    image: Appimageassets.conditions,
    color: const Color(0xFFF59E0B),
    color2: const Color(0xFFB45309),
    onTap: () {
      Get.toNamed(Approutes.obligations);
    },
  ),

  Cardservicesmodel(
    title: "93".tr,
    image: Appimageassets.questions,
    color: const Color(0xFF10B981),
    color2: const Color(0xFF065F46),
    onTap: () {
      Get.toNamed(Approutes.questions);
    },
  ),

  Cardservicesmodel(
    title: "27".tr,
    image: Appimageassets.rejester,
    color: const Color(0xFF14B8A6),
    color2: const Color(0xFF0F766E),
    onTap: () {
      Get.toNamed(Approutes.persontype);
    },
  ),

  Cardservicesmodel(
    title: "28".tr,
    image: Appimageassets.calcel,
    color: Color(0xff34C759),
    color2: Color(0xff19612B),
  ),
];

List<Institutiontypemodel> institutionfild = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.institutiontype);
    },
    body: "31".tr,
    imgae: Appimageassets.oneCard,
    color1: Color(0xff164573),
    color2: Color(0xff473BF0),
    sizeText: 36,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.regulatedinstitutiontypes);
    },
    body: "32".tr,
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
    body: "33".tr,
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
    body: "34".tr,
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
    body: "35".tr,
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
    body: "36".tr,
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
    body: "37".tr,
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
    body: "38".tr,
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
    body: "39".tr,
    imgae: Appimageassets.nineCard,
    color1: Color(0xff3C581F),
    color2: Color(0xff82BE42),
    sizeText: Get.locale == Locale("fr") ? 18 : 24,
  ),
];

List<Institutiontypemodel> taxsystemstype = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesTax, arguments: {"name": 49, "type": 9});
    },
    body: "49".tr,
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesTax, arguments: {"name": 50, "type": 10});
    },
    body: "50".tr,
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesTax, arguments: {"name": 48, "type": 8});
    },
    body: "48".tr,
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> taxsystemstypeapp = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesapp, arguments: {"name": 29, "type": 12});
    },
    body: "49".tr,
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesapp, arguments: {"name": 29, "type": 13});
    },
    body: "50".tr,
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.categoriesapp, arguments: {"name": 29, "type": 11});
    },
    body: "48".tr,
    imgae: Appimageassets.tenCard,
    color1: Color(0xff4F46E5),
    color2: Color(0xff8B5CF6),
    sizeText: 24,
  ),
];

List<Institutiontypemodel> obligationstype = [
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"type": 2});
    },
    body: "49".tr,
    imgae: Appimageassets.elevenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
  Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"type": 3});
    },
    body: "50".tr,
    imgae: Appimageassets.twelveCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),
    Institutiontypemodel(
    ontap: () {
      Get.toNamed(Approutes.specialappointments, arguments: {"type": 1});
    },
    body: "48".tr,
    imgae: Appimageassets.tenCard,
    color2: Color(0xFF7333BD),
    color1: Color(0xff270C46),
    sizeText: 24,
  ),

];
