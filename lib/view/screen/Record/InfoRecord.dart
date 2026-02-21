import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/InforecordController.dart';
import '../../../core/class/Statusrequest.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../core/constant/routes.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Records/CustemBusinessCardditails.dart';

class Inforecord extends StatefulWidget {
  const Inforecord({super.key});

  @override
  State<Inforecord> createState() => _InforecordState();
}

class _InforecordState extends State<Inforecord> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InforecordcontrollerImp());

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("تفاصيل السجل".tr)),
      body: GetBuilder<InforecordcontrollerImp>(
        builder: (_) {
          if (controller.recordStatus == Statusrequest.loadeng) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.recordStatus == Statusrequest.failure ||
              controller.data.isEmpty) {
            return Center(child: Text("لا توجد بيانات".tr));
          }

          final item = controller.data[0];

          return Stack(
            children: [
              // Scrollable content
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    // ===== Business Card =====
                    Custembusinesscardditails(
                      acteve: item.activityName == null
                          ? item.activitSpecial == 1
                                ? "شركة مدنية".tr
                                : "شركة أخرى"
                          : item.localizedActivityName,
                      condition: 1,
                      persontype: item.personType == 1 ? "58".tr : "59".tr,
                      name: item.username,
                      address: item.wilaya,
                      numperTax: item.taxId == 0
                          ? "49".tr
                          : item.taxId == 1
                          ? "50".tr
                          : "48".tr,
                      codeActeve: item.codeActivity ?? "",
                    ),
                    const SizedBox(height: 20),
                    // ===== Appointments Section =====
                    Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: AppColor.acteve,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'المواعيد والالتزامات'.tr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.appointments.isNotEmpty)
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Approutes.specialappointments,
                                      arguments: {"tax_id": controller.taxid},
                                    );
                                  },
                                  child: Text(
                                    'عرض الكل'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.acteve,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (controller.appointmentStatus ==
                            Statusrequest.loadeng)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        else if (controller.appointments.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 80),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.event_note_rounded,
                                  size: 60,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "لا توجد مواعيد حالياً".tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.appointments.length,
                            itemBuilder: (context, i) {
                              final appt = controller.appointments[i];
                              return AppointmentCard(
                                title: appt.declaration,
                                date: appt.deadline,
                                dec: appt.declaration,
                                status: DateTime.parse(
                                  appt.deadline,
                                ).isBefore(DateTime.now()),
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              // ===== Buttons Fixed at Bottom =====
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: (Get.width - 40) / 2,
                        child: Custemsuberbutton(
                          content: "تعديل".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            if (item.taxId == 0) {
                              controller.gotoEditRecord();
                            } else {
                              Get.defaultDialog(
                                title: "ملاحظة".tr,
                                titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                  fontSize: 20,
                                ),
                                radius: 20,
                                middleText:
                                    "لا يمكن تعديل النظام الجبائي بعد اعتماده."
                                        .tr,
                                confirm: SizedBox(
                                  width: 150,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.typography,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      "حسنًا".tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10), // <-- صححت هنا
                      SizedBox(
                        width: (Get.width - 40) / 2,
                        child: Custemsuberbutton(
                          content: "حذف".tr,
                          color: AppColor.red,
                          onPressed: () {
                            controller.daletedata();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatefulWidget {
  final String title;
  final String date;
  final String dec;
  final bool status;

  const AppointmentCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.dec,
  });

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isPast = widget.status == true;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isPast ? Colors.grey.shade100 : Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPast ? Colors.grey.shade400 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isPast ? Colors.grey : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              isPast ? Icons.event_busy : Icons.schedule,
                              size: 14,
                              color: isPast
                                  ? Colors.orange.shade600
                                  : Colors.blue,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "الموعد النهائي: ${widget.date}",
                              style: TextStyle(
                                fontSize: 12,
                                color: isPast
                                    ? Colors.orange.shade600
                                    : Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0, // 90° عند التوسيع
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.chevron_left, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Expanded Details
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isPast
                        ? Colors.orange.shade100
                        : Colors.blue.shade100,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "التبعات المترتبة".tr,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.dec,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
