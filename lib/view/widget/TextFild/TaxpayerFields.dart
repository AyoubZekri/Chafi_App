import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/TaxpayerTypes.dart';
import '../../../core/functions/ArabicStretch.dart';
import 'Dropdownfild.dart';

/// اختيار صفة المكلف بالضريبة، وسؤال التسجيل في الإدارة الجبائية
/// يظهر فقط للمؤسسة الناشئة والمصغرة والأخرى، وللمسجل: طبيعة الشخص
/// والنظام الجبائي وسنة التسجيل
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
          hintText: "صفة المكلف بالضريبة".tr,
          icon: Icons.badge_outlined,
          fontSize: 14,
          errorText: controller.taxpayerTypeError,
          items: [
            for (int i = 0; i < TaxpayerTypes.all.length; i++)
              DropdownMenuItem<String>(
                value: TaxpayerTypes.all[i],
                child: Text(shown[i], style: const TextStyle(fontSize: 14)),
              ),
          ],
          value: controller.taxpayerType,
          onChanged: controller.setTaxpayerType,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: controller.showRegistration
              ? Dropdownfild<bool>(
                  hintText: "مسجل في الإدارة الجبائية؟".tr,
                  icon: Icons.account_balance_outlined,
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
        // للمسجل فقط: طبيعة الشخص، النظام الجبائي، ثم سنة التسجيل (اختيارية)
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: controller.showRegisteredDetails
              ? Column(
                  children: [
                    Dropdownfild<String>(
                      hintText: "طبيعة الشخص".tr,
                      icon: Icons.person_outline,
                      fontSize: 14,
                      errorText: controller.personTypeError,
                      items: [
                        for (final type in PersonTypes.all)
                          DropdownMenuItem<String>(
                            value: type,
                            child: Text(
                              PersonTypes.label(type),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                      value: controller.personType,
                      onChanged: controller.setPersonType,
                    ),
                    Dropdownfild<String>(
                      hintText: "النظام الجبائي".tr,
                      icon: Icons.account_tree_outlined,
                      fontSize: 14,
                      errorText: controller.taxSystemError,
                      items: [
                        for (final system in TaxSystemTypes.all)
                          DropdownMenuItem<String>(
                            value: system,
                            child: Text(
                              TaxSystemTypes.label(system),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                      value: controller.taxSystem,
                      onChanged: controller.setTaxSystem,
                    ),
                    // سنة فقط (بدون يوم وشهر)
                    Dropdownfild<int>(
                      hintText: "سنة التسجيل".tr,
                      icon: Icons.pin_outlined,
                      itemIcon: Icons.pin_outlined,
                      fontSize: 14,
                      items: [
                        for (final year in TaxpayerFormMixin.registrationYears)
                          DropdownMenuItem<int>(
                            value: year,
                            child: Text(
                              year.toString(),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                      ],
                      value: controller.registrationYear,
                      onChanged: controller.setRegistrationYear,
                    ),
                  ],
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}
