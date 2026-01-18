import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';

class DeadlineAlertCard extends StatelessWidget {
  final String title;
  final String deadline;
  final String consequences;

  const DeadlineAlertCard({
    super.key,
    required this.title,
    required this.deadline,
    required this.consequences,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColor.primarycolor.withOpacity(0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.typography.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// العنوان
          Row(
            children: [
              Icon(Icons.notifications_active, color: AppColor.primarycolor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// الموعد النهائي
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.acteve.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: AppColor.typography,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  "آخر أجل: $deadline",
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: AppColor.typography,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// العواقب
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded, color: AppColor.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    consequences,
                    style: const TextStyle(
                      fontSize: 14.5,
                      color: AppColor.red,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
