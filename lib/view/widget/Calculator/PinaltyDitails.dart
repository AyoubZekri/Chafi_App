// ====================== Final Tax Card ======================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../core/constant/extension.dart';

class FinalTaxCard extends StatelessWidget {
  final int netTax;
  final int penalty;
  final String title;
  final bool penaltys;

  const FinalTaxCard({
    super.key,
    required this.netTax,
    required this.title,
    required this.penalty,
    this.penaltys = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // الضريبة النهائية
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Colors.blue.shade700,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ),
                AmountText(
                  amount: (netTax >= 0 ? netTax : -netTax)
                      .toString()
                      .formatCustom(),
                  color: AppColor.black,
                ),
              ],
            ),
          ),
          if (penaltys == true) Divider(height: 1, color: Colors.grey.shade100),
          if (penaltys == true)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'عقوبة تأخير الضريبة النهائية'.tr,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  AmountText(
                    amount: penalty.toString().formatCustom(),
                    color: Colors.red,
                    isSmall: true,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ====================== Total Amount Card ======================
class TotalAmountCard extends StatelessWidget {
  final int total;
  final bool text;
  final String title;

  TotalAmountCard({
    super.key,
    required this.total,
    this.text = false,
    String? title,
  }) : title =
           title ?? (total < 0 ? 'الفائض'.tr : 'المجموع الكلي الواجب دفعه'.tr);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: AppColor.typography,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColor.typography.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  total > 0
                      ? total.formatCustomint().toString()
                      : (-total).formatCustomint().toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'دينار الجزائري'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (text)
                  Text(
                    "الحد الأقصى الواجب دفعه 1,000,000,00".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          // زخارف الخلفية
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================== Amount Text ======================
class AmountText extends StatelessWidget {
  final String amount;
  final bool isSmall;
  final Color color;

  const AmountText({
    super.key,
    required this.amount,
    this.isSmall = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          amount,
          style: TextStyle(
            fontWeight: isSmall ? FontWeight.w600 : FontWeight.bold,
            fontSize: isSmall ? 14 : 16,
            color: color,
          ),
        ),
        SizedBox(width: 5),
        Text(
          'DA'.tr,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColor.typography),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: AppColor.grey,
            fontSize: 13,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ====================== Penalty Card ======================
class PenaltyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;

  const PenaltyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.icon = Icons.warning_amber_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue.shade700, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: AppColor.black),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            width: double.infinity,
            height: 1,
            color: AppColor.grey.withOpacity(0.2),
          ),
          Container(
            alignment: Get.locale?.languageCode == "ar"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown, // يصغر النص إذا لازم، بدون كسر السطر
              alignment: Alignment.centerRight,
              child: AmountText(
                amount: amount.formatCustom(),
                isSmall: false,
                color: AppColor.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TotalAmountCarddealog extends StatelessWidget {
  final int total;
  final bool text;

  const TotalAmountCarddealog({
    super.key,
    required this.total,
    this.text = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: AppColor.typography,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.typography.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                total < 0 ? 'الفائض'.tr : 'المجموع الكلي الواجب دفعه'.tr,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                total > 0
                    ? total.formatCustomint().toString()
                    : (-total).formatCustomint().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'دينار الجزائري'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
