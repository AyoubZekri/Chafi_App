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

class DeadlineAlertCard extends StatefulWidget {
  final String title;
  final List<dynamic>? appointmentDates;

  const DeadlineAlertCard({
    super.key,
    required this.title,
    this.appointmentDates,
  });

  @override
  State<DeadlineAlertCard> createState() => _DeadlineAlertCardState();
}

class _DeadlineAlertCardState extends State<DeadlineAlertCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            border: const Border(
              right: BorderSide(
                color: AppColor.typography,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.typography,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.typography,
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),

                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: isExpanded && widget.appointmentDates != null && widget.appointmentDates!.isNotEmpty
                      ? Column(
                          children: widget.appointmentDates!.map((dateItem) {
                            String d = dateItem.appointmentDate ?? '';
                            if (d.length >= 10) d = d.substring(5, 10);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${"الموعد:".tr} $d",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      : Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${"المواعيد".tr} (${widget.appointmentDates?.length ?? 0})",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
