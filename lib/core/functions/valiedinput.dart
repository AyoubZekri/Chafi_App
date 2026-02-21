import 'package:chafi/core/functions/Snacpar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

validInput(String val, int max, int min, String type) {
  if (val.isEmpty) {
    return "Can't be Empty".tr;
  }
  if (type == 'username') {
    if (GetUtils.isUsername(val)) {
      return "not valid username".tr;
    }
  }
  if (type == 'Email') {
    if (GetUtils.isUsername(val)) {
      return "not valid Email".tr;
    }
  }
  if (type == 'phone') {
    if (GetUtils.isUsername(val)) {
      return "not valid phone".tr;
    }
  }

  if (type == 'int') {
    if (int.tryParse(val) == null) {
      return "Must be an integer".tr;
    }
  }
  if (type == 'double') {
    if (double.tryParse(val) == null) {
      return "Must be a decimal number".tr;
    }
  }

  if (val.isEmpty) {
    return "Can't be Empty".tr;
  }

  if (val.length > max) {
    return "${"Can't be larger than".tr} $max";
  }
  if (val.length < min) {
    return "${"Can't be less than".tr} $min";
  }
}

bool validInputsnak(String val, int min, int max, String type) {
  if (val.isEmpty) {
    showSnackbar("خطأ".tr, "لا يمكن أن يكون الحقل فارغًا".tr, Colors.red);
    return false;
  }

  if (val.length > max) {
    showSnackbar(
      "error".tr,
      "${'لا يمكن أن يكون حقل'.tr} $type ${'أطول من'.tr} $max ${'حرف'.tr}",
      Colors.red,
    );
    return false;
  }

  if (val.length < min) {
    showSnackbar(
      "error".tr,
      "${'لا يمكن أن يكون حقل'.tr} $type ${'أقل من'.tr}  $min ${'حرف'.tr}",
      Colors.red,
    );
    return false;
  }

  if (type == 'username' && !GetUtils.isUsername(val)) {
    showSnackbar("error".tr, "اسم المستخدم غير صالح".tr, Colors.red);
    return false;
  }

  if (type == 'email' && !GetUtils.isEmail(val)) {
    showSnackbar("error".tr, "البريد الإلكتروني غير صالح".tr, Colors.red);
    return false;
  }

  if (type == 'phone' && !GetUtils.isPhoneNumber(val)) {
    showSnackbar("error".tr, "رقم الهاتف غير صالح".tr, Colors.red);
    return false;
  }

  return true;
}
