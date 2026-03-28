import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:get/get.dart';

Flushbar? _currentFlushbar;

void showSnackbar(String titleKey, String messageKey, Color color) {
  final context = Get.context;
  if (context == null) return;

  // إزالة أي Flushbar حالية
  _currentFlushbar?.dismiss();
  _currentFlushbar = null;

  IconData iconData;
  if (color == Colors.green) {
    iconData = Icons.check_circle;
  } else if (color == Colors.red) {
    iconData = Icons.error;
  } else if (color == Colors.orange) {
    iconData = Icons.warning;
  } else {
    iconData = Icons.info;
  }

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _currentFlushbar =
        Flushbar(
            margin: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(12),
            backgroundColor: color,
            icon: Icon(iconData, color: Colors.white),
            titleText: Text(
              titleKey.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            messageText: Text(
              messageKey.tr,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            isDismissible: true,
          )
          ..show(context).then((_) {
            _currentFlushbar = null; // إعادة تعيين بعد الإغلاق
          });
  });
}

void showTopError(String messageKey) {
  final context = Get.context;
  if (context == null) return;

  _currentFlushbar?.dismiss();
  _currentFlushbar = null;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _currentFlushbar =
        Flushbar(
            margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            borderRadius: BorderRadius.circular(20),

            backgroundColor: Colors.black.withOpacity(0.5),

            // ❌ بدون title
            titleText: const SizedBox(),

            // ✅ النص في الوسط
            messageText: Center(
              child: Text(
                messageKey.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),

            duration: const Duration(seconds: 2),

            flushbarPosition: FlushbarPosition.BOTTOM,

            // animation ناعمة
            animationDuration: const Duration(milliseconds: 550),

            // يمنع swipe
            isDismissible: false,

            // shadow خفيف
            boxShadows: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8),
            ],
          )
          ..show(context).then((_) {
            _currentFlushbar = null;
          });
  });
}
