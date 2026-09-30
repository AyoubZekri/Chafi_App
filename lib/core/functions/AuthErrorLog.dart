import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../class/Crud.dart';

/// وصف مفصل لأخطاء تسجيل الدخول بـ Google (من الهاتف أو من السيرفر)
String describeAuthError(Object e) {
  if (e is FirebaseAuthException) {
    return 'FirebaseAuthException code=${e.code} message=${e.message}'
        '${_hint(e.code, e.message)}';
  }
  if (e is PlatformException) {
    return 'PlatformException code=${e.code} message=${e.message}'
        '${e.details != null ? ' details=${e.details}' : ''}'
        '${_hint(e.code, e.message)}';
  }
  return '${e.runtimeType}: $e${_hint('', e.toString())}';
}

/// أسباب شائعة معروفة حسب رمز الخطأ
String _hint(String code, String? message) {
  final text = '$code ${message ?? ''}';
  if (text.contains('ApiException: 10') || text.contains('DEVELOPER_ERROR')) {
    return '\n   ⚠️ السبب المرجح: بصمة SHA-1/SHA-256 للتطبيق غير مسجلة في Firebase'
        ' (أو ملف google-services.json قديم).';
  }
  if (text.contains('ApiException: 7') || code == 'network_error' ||
      code == 'network-request-failed') {
    return '\n   ⚠️ السبب المرجح: مشكلة في الاتصال بالإنترنت أثناء تسجيل الدخول.';
  }
  if (text.contains('ApiException: 12500')) {
    return '\n   ⚠️ السبب المرجح: إعدادات OAuth / البريد الداعم ناقصة في Google Cloud أو Firebase.';
  }
  if (text.contains('ApiException: 12501') || code == 'sign_in_canceled') {
    return '\n   ℹ️ ألغى المستخدم تسجيل الدخول.';
  }
  if (code == 'account-exists-with-different-credential') {
    return '\n   ⚠️ هذا البريد مسجل بطريقة دخول أخرى في Firebase.';
  }
  return '';
}

/// سطر واحد مختصر للمستخدم (بدون التلميح)
String shortAuthError(Object e) {
  if (e is FirebaseAuthException) return '${e.code}: ${e.message ?? ''}';
  if (e is PlatformException) return '${e.code}: ${e.message ?? ''}';
  return e.toString();
}

/// طباعة الخطأ بشكل مفصل في الـ console
void logAuthError(String step, Object e, [StackTrace? stack]) {
  print('❌ [$step] ${describeAuthError(e)}');
  if (stack != null) print(stack);
}

/// طباعة فشل رد السيرفر (تسجيل الدخول / إنشاء الحساب)
void logAuthServerFailure(String step, dynamic response) {
  print('❌ [$step] فشل رد السيرفر');
  print('   -> السبب: ${Crud.lastError ?? 'غير معروف'}');
  print('   -> الرد: $response');
}

/// رسالة قصيرة للمستخدم من آخر خطأ في السيرفر
String authErrorForUser(String fallback) {
  final reason = Crud.lastError;
  return reason == null || reason.isEmpty ? fallback : '$fallback ($reason)';
}
