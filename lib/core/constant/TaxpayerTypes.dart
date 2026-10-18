import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/Snacpar.dart';
import '../services/Services.dart';

/// أنواع المكلف بالضريبة. القيمة المحفوظة في قاعدة البيانات (users.is_taxpayer)
/// هي الرمز الثابت، والنص المعروض يأتي من الترجمة "taxpayer_<الرمز>".
class TaxpayerTypes {
  static const String startup = 'startup';
  static const String microEnterprise = 'micro_enterprise';
  static const String otherEnterprise = 'other_enterprise';
  static const String student = 'student';
  static const String researcher = 'researcher';
  static const String taxInterested = 'tax_interested';
  static const String privateAccountant = 'private_accountant';
  static const String publicAccountant = 'public_accountant';

  static const List<String> all = [
    startup,
    microEnterprise,
    otherEnterprise,
    student,
    researcher,
    taxInterested,
    privateAccountant,
    publicAccountant,
  ];

  /// المؤسسات: يُسأل صاحبها هل هو مسجل في الإدارة الجبائية
  static const Set<String> enterprises = {
    startup,
    microEnterprise,
    otherEnterprise,
  };

  static bool isEnterprise(String? type) => enterprises.contains(type);

  static String label(String type) => 'taxpayer_$type'.tr;
}

/// حقول "المكلف بالضريبة" و"مسجل في الإدارة الجبائية" المشتركة
/// بين إنشاء الحساب وتعديله
mixin TaxpayerFormMixin on GetxController {
  String? taxpayerType;
  bool? registeredTaxAdmin;

  /// سنة التسجيل في الإدارة الجبائية (للمسجل فقط)
  int? registrationYear;

  /// السنوات المتاحة: من السنة الحالية إلى 1962
  static List<int> get registrationYears => [
    for (int y = DateTime.now().year; y >= 1962; y--) y,
  ];

  // بعد محاولة الحفظ تظهر رسالة تحت كل حقل إجباري فارغ
  bool taxpayerSubmitted = false;

  String? get taxpayerTypeError =>
      taxpayerSubmitted && taxpayerType == null ? "هذا الحقل إجباري".tr : null;

  String? get registrationError =>
      taxpayerSubmitted && showRegistration && registeredTaxAdmin == null
      ? "هذا الحقل إجباري".tr
      : null;

  String? get registrationYearError =>
      taxpayerSubmitted && showRegistrationYear && registrationYear == null
      ? "هذا الحقل إجباري".tr
      : null;

  bool get showRegistration => TaxpayerTypes.isEnterprise(taxpayerType);

  /// سنة التسجيل تُطلب فقط إذا اختار "مسجل"
  bool get showRegistrationYear =>
      showRegistration && registeredTaxAdmin == true;

  void setTaxpayerType(String? type) {
    taxpayerType = type;
    // سؤال التسجيل خاص بالمؤسسات فقط
    if (!TaxpayerTypes.isEnterprise(type)) {
      registeredTaxAdmin = null;
      registrationYear = null;
    }
    update();
  }

  void setRegisteredTaxAdmin(bool? value) {
    registeredTaxAdmin = value;
    if (value != true) registrationYear = null;
    update();
  }

  void setRegistrationYear(int? year) {
    registrationYear = year;
    update();
  }

  /// يعرض رسالة ويرجع false إذا نقصت إجابة
  bool validateTaxpayer() {
    taxpayerSubmitted = true;
    update();
    if (taxpayerType == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار صفة المكلف بالضريبة".tr, Colors.red);
      return false;
    }
    if (showRegistration && registeredTaxAdmin == null) {
      showSnackbar(
        "خطأ".tr,
        "يرجى تحديد هل أنت مسجل في الإدارة الجبائية".tr,
        Colors.red,
      );
      return false;
    }
    if (showRegistrationYear && registrationYear == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار سنة التسجيل".tr, Colors.red);
      return false;
    }
    return true;
  }

  /// القيم المرسلة للسيرفر (نص فارغ = null في Laravel)
  Map<String, String> get taxpayerRequestData => {
    "is_taxpayer": taxpayerType ?? "",
    "is_registered_tax_admin": registeredTaxAdmin == null
        ? ""
        : (registeredTaxAdmin! ? "1" : "0"),
    "registration_year": showRegistrationYear
        ? registrationYear.toString()
        : "",
  };

  void loadTaxpayerFromPrefs() {
    final prefs = Get.find<Myservices>().sharedPreferences;
    final type = prefs?.getString("is_taxpayer");
    taxpayerType = TaxpayerTypes.all.contains(type) ? type : null;
    final registered = prefs?.getString("is_registered_tax_admin") ?? "";
    registeredTaxAdmin = registered.isEmpty ? null : registered == "1";
    if (!showRegistration) registeredTaxAdmin = null;
    registrationYear = int.tryParse(
      prefs?.getString("registration_year") ?? "",
    );
    if (!showRegistrationYear) registrationYear = null;
  }
}

/// حفظ القيمتين في الهاتف من رد السيرفر (تسجيل الدخول/إنشاء الحساب/التعديل)
void saveTaxpayerToPrefs(dynamic user) {
  if (user is! Map) return;
  final prefs = Get.find<Myservices>().sharedPreferences;
  prefs?.setString("is_taxpayer", user["is_taxpayer"]?.toString() ?? "");
  final registered = user["is_registered_tax_admin"];
  prefs?.setString(
    "is_registered_tax_admin",
    registered == null
        ? ""
        : (registered == true || registered.toString() == "1" ? "1" : "0"),
  );
  prefs?.setString(
    "registration_year",
    user["registration_year"]?.toString() ?? "",
  );
}
