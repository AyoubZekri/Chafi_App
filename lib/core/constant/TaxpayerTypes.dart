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

/// طبيعة الشخص المسجل في الإدارة الجبائية (users.person_type)
class PersonTypes {
  static const String natural = 'natural';
  static const String legal = 'legal';

  static const List<String> all = [natural, legal];

  static String label(String type) => type == natural ? "58".tr : "59".tr;
}

/// النظام الجبائي للمسجل، نفس الأنظمة الثلاثة في التطبيق (users.tax_system)
class TaxSystemTypes {
  static const String real = 'real';
  static const String flatRate = 'flat_rate';
  static const String simplified = 'simplified';

  static const List<String> all = [real, flatRate, simplified];

  static String label(String type) => switch (type) {
    real => "48".tr,
    flatRate => "49".tr,
    _ => "50".tr,
  };
}

/// حقول "المكلف بالضريبة" و"مسجل في الإدارة الجبائية" المشتركة
/// بين إنشاء الحساب وتعديله
mixin TaxpayerFormMixin on GetxController {
  String? taxpayerType;
  bool? registeredTaxAdmin;

  /// للمسجل فقط: طبيعة الشخص والنظام الجبائي (إجباريان)، وسنة التسجيل (اختيارية)
  String? personType;
  String? taxSystem;
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

  String? get personTypeError =>
      taxpayerSubmitted && showRegisteredDetails && personType == null
      ? "هذا الحقل إجباري".tr
      : null;

  String? get taxSystemError =>
      taxpayerSubmitted && showRegisteredDetails && taxSystem == null
      ? "هذا الحقل إجباري".tr
      : null;

  bool get showRegistration => TaxpayerTypes.isEnterprise(taxpayerType);

  /// طبيعة الشخص والنظام الجبائي وسنة التسجيل تظهر فقط إذا اختار "مسجل"
  bool get showRegisteredDetails =>
      showRegistration && registeredTaxAdmin == true;

  void _clearRegisteredDetails() {
    personType = null;
    taxSystem = null;
    registrationYear = null;
  }

  void setTaxpayerType(String? type) {
    taxpayerType = type;
    // سؤال التسجيل خاص بالمؤسسات فقط
    if (!TaxpayerTypes.isEnterprise(type)) {
      registeredTaxAdmin = null;
      _clearRegisteredDetails();
    }
    update();
  }

  void setRegisteredTaxAdmin(bool? value) {
    registeredTaxAdmin = value;
    if (value != true) _clearRegisteredDetails();
    update();
  }

  void setPersonType(String? type) {
    personType = type;
    update();
  }

  void setTaxSystem(String? system) {
    taxSystem = system;
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
    if (showRegisteredDetails && personType == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار طبيعة الشخص".tr, Colors.red);
      return false;
    }
    if (showRegisteredDetails && taxSystem == null) {
      showSnackbar("خطأ".tr, "يرجى اختيار النظام الجبائي".tr, Colors.red);
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
    "person_type": showRegisteredDetails ? personType ?? "" : "",
    "tax_system": showRegisteredDetails ? taxSystem ?? "" : "",
    "registration_year": showRegisteredDetails && registrationYear != null
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
    final person = prefs?.getString("person_type");
    personType = PersonTypes.all.contains(person) ? person : null;
    final system = prefs?.getString("tax_system");
    taxSystem = TaxSystemTypes.all.contains(system) ? system : null;
    if (!showRegisteredDetails) _clearRegisteredDetails();
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
  prefs?.setString("person_type", user["person_type"]?.toString() ?? "");
  prefs?.setString("tax_system", user["tax_system"]?.toString() ?? "");
}
