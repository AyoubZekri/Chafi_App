import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class DeadlineAlertCard extends StatelessWidget {
//   final String title;
//   final String deadline;
//   final String consequences;

//   const DeadlineAlertCard({
//     super.key,
//     required this.title,
//     required this.deadline,
//     required this.consequences,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(
//           color: AppColor.primarycolor.withOpacity(0.6),
//           width: 1,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: AppColor.typography.withOpacity(0.12),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// العنوان
//           Row(
//             children: [
//               Icon(Icons.notifications_active, color: AppColor.primarycolor),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w700,
//                     color: AppColor.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 14),

//           /// الموعد النهائي
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: AppColor.acteve.withOpacity(0.15),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.calendar_month,
//                   color: AppColor.typography,
//                   size: 20,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   "آخر أجل: $deadline",
//                   style: const TextStyle(
//                     fontSize: 15.5,
//                     fontWeight: FontWeight.w600,
//                     color: AppColor.typography,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 16),

//           /// العواقب
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: AppColor.red.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(Icons.warning_amber_rounded, color: AppColor.red),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Text(
//                     consequences,
//                     style: const TextStyle(
//                       fontSize: 14.5,
//                       color: AppColor.red,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DeadlineAlertCard extends StatelessWidget {
  final String title;
  final String dateText;
  final String subtitleLabel;
  final String subtitleValue;
  final bool isOverdue;

  const DeadlineAlertCard({
    super.key,
    required this.title,
    required this.dateText,
    required this.subtitleLabel,
    required this.subtitleValue,
    this.isOverdue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColor.typography.withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border(
            right: BorderSide(
              color: isOverdue ? Colors.red : const Color(0xFF137fec),
              width: 4,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              /// Date row
              Row(
                children: [
                  Icon(
                    isOverdue ? Icons.history : Icons.calendar_today,
                    size: 18,
                    color: isOverdue ? Colors.red : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isOverdue == true
                        ? "${"إنتهاء في:".tr}  ${dateText}"
                        : "${"الموعد النهائي:".tr}  ${dateText}",
                    style: TextStyle(
                      fontSize: 13,
                      color: isOverdue ? Colors.red : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// Info box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isOverdue
                      ? Colors.red.withOpacity(0.05)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isOverdue
                        ? Colors.red.withOpacity(0.2)
                        : Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isOverdue ? Icons.warning : Icons.info,
                      size: 18,
                      color: isOverdue ? Colors.red : const Color(0xFF137fec),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subtitleLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isOverdue
                                  ? Colors.red
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitleValue,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isOverdue
                                  ? Colors.red.shade700
                                  : Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
