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

  // بعد محاولة الحفظ تظهر رسالة تحت كل حقل إجباري فارغ
  bool taxpayerSubmitted = false;

  String? get taxpayerTypeError =>
      taxpayerSubmitted && taxpayerType == null ? "هذا الحقل إجباري".tr : null;

  String? get registrationError =>
      taxpayerSubmitted && showRegistration && registeredTaxAdmin == null
          ? "هذا الحقل إجباري".tr
          : null;

  bool get showRegistration => TaxpayerTypes.isEnterprise(taxpayerType);

  void setTaxpayerType(String? type) {
    taxpayerType = type;
    // سؤال التسجيل خاص بالمؤسسات فقط
    if (!TaxpayerTypes.isEnterprise(type)) registeredTaxAdmin = null;
    update();
  }

  void setRegisteredTaxAdmin(bool? value) {
    registeredTaxAdmin = value;
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
    return true;
  }

  /// القيم المرسلة للسيرفر (نص فارغ = null في Laravel)
  Map<String, String> get taxpayerRequestData => {
        "is_taxpayer": taxpayerType ?? "",
        "is_registered_tax_admin": registeredTaxAdmin == null
            ? ""
            : (registeredTaxAdmin! ? "1" : "0"),
      };

  void loadTaxpayerFromPrefs() {
    final prefs = Get.find<Myservices>().sharedPreferences;
    final type = prefs?.getString("is_taxpayer");
    taxpayerType = TaxpayerTypes.all.contains(type) ? type : null;
    final registered = prefs?.getString("is_registered_tax_admin") ?? "";
    registeredTaxAdmin = registered.isEmpty ? null : registered == "1";
    if (!showRegistration) registeredTaxAdmin = null;
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
}
