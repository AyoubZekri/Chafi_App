import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardconferm extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  final VoidCallback? onTapTerms;

  const Custemcardconferm({
    super.key,
    required this.value,
    this.onChanged,
    this.onTapTerms,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTapTerms,
              child: RichText(
                text: TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: AppColor.grey,
                  ),
                  children: [
                    TextSpan(text: "أوافق على ".tr),
                    TextSpan(
                      text: "الشروط والأحكام".tr,
                      style: TextStyle(
                        color: AppColor.brand,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue.shade900,
            activeTrackColor: Colors.blue.shade200,
            inactiveThumbColor: Colors.grey.shade500,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
