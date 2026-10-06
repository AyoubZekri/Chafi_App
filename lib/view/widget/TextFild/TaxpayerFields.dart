import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/TaxpayerTypes.dart';
import '../../../core/functions/ArabicStretch.dart';
import 'Dropdownfild.dart';

/// اختيار صفة المكلف بالضريبة، وسؤال التسجيل في الإدارة الجبائية
/// يظهر فقط للمؤسسة الناشئة والمصغرة والأخرى
class TaxpayerFields extends StatelessWidget {
  final TaxpayerFormMixin controller;

  const TaxpayerFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // بالعربية: الأسماء القصيرة تُطال بالتطويل "ـ" لتقارب طول أطولها
    final labels = TaxpayerTypes.all.map(TaxpayerTypes.label).toList();
    final isArabic = (Get.locale?.languageCode ?? 'ar') == 'ar';
    final shown = isArabic
        ? stretchToLongest(
            labels,
            DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
          )
        : labels;

    return Column(
      children: [
        Dropdownfild<String>(
          hintText: "${"صفة المكلف بالضريبة".tr} *",
          icon: Icons.badge_outlined,
          maxLines: 3,
          fontSize: 14,
          errorText: controller.taxpayerTypeError,
          items: [
            for (int i = 0; i < TaxpayerTypes.all.length; i++)
              DropdownMenuItem<String>(
                value: TaxpayerTypes.all[i],
                child: Text(
                  shown[i],
                  style: const TextStyle(fontSize: 14),
                ),
              ),
          ],
          value: controller.taxpayerType,
          onChanged: controller.setTaxpayerType,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: controller.showRegistration
              ? Dropdownfild<bool>(
                  hintText: "${"مسجل في الإدارة الجبائية؟".tr} *",
                  icon: Icons.account_balance_outlined,
                  maxLines: 3,
                  fontSize: 14,
                  errorText: controller.registrationError,
                  items: [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text(
                        "مسجل في الإدارة الجبائية".tr,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text(
                        "غير مسجل في الإدارة الجبائية".tr,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                  value: controller.registeredTaxAdmin,
                  onChanged: controller.setRegisteredTaxAdmin,
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
