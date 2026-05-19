import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/InforecordController.dart';
import '../../../core/class/Statusrequest.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../core/constant/routes.dart';
import '../../../core/functions/Snacpar.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Records/CustemBusinessCardditails.dart';

class Inforecord extends StatefulWidget {
  const Inforecord({super.key});

  @override
  State<Inforecord> createState() => _InforecordState();
}

class _InforecordState extends State<Inforecord> {
  final controller = Get.put(InforecordcontrollerImp());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<InforecordcontrollerImp>().back();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Subtle background for depth
        appBar: AppBar(
          title: Text(
            "تفاصيل السجل".tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.typography,
              fontSize: 22,
            ),
          ),
          backgroundColor: AppColor.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColor.typography),
        ),
        body: GetBuilder<InforecordcontrollerImp>(
          builder: (_) {
            if (controller.recordStatus != Statusrequest.success) {
              return Handlingview(
                statusrequest: controller.recordStatus,
                widget: const SizedBox(),
              );
            }

            final item = controller.data[0];

            return Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 120, // Space for bottom buttons
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ===== Business Card =====
                      Custembusinesscardditails(
                        acteve: item.activityName == null
                            ? item.activitSpecial == 1
                                  ? "شركة مدنية".tr
                                  : "شركة أخرى".tr
                            : item.localizedActivityName,
                        condition: 1,
                        persontype: item.personType == 1 ? "58".tr : "59".tr,
                        name: item.username,
                        address: item.wilaya.tr,
                        numperTax: item.taxId == 0
                            ? "49".tr
                            : item.taxId == 1
                            ? "50".tr
                            : "48".tr,
                        codeActeve: item.codeActivity.toString().tr,
                      ),

                      const SizedBox(height: 35),

                      // ===== Appointments Section =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColor.primarycolor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.calendar_month_rounded,
                                  color: AppColor.primarycolor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'المواعيد والالتزامات'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.typography,
                                ),
                              ),
                            ],
                          ),
                          if (controller.appointments.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                Get.toNamed(
                                  Approutes.specialappointments,
                                  arguments: {"tax_id": controller.taxid},
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: AppColor.primarycolor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'عرض الكل'.tr,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      if (controller.appointmentStatus == Statusrequest.loadeng)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primarycolor,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      else if (controller.appointments.isEmpty)
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColor.grey.withOpacity(0.1),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColor.grey.withOpacity(0.05),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.event_available_rounded,
                                    size: 50,
                                    color: AppColor.grey.withOpacity(0.4),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "لا توجد مواعيد حالياً".tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.typography.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.appointments.length > 3
                              ? 3
                              : controller.appointments.length,
                          itemBuilder: (context, i) {
                            final appt = controller.appointments[i];
                            return AppointmentCard(
                              title: appt.declaration,
                              date: appt.deadline.substring(5, 10),
                              dec: appt.dependencies,
                              status: DateTime.parse(
                                appt.deadline,
                              ).isBefore(DateTime.now()),
                            );
                          },
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
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 30, // SafeArea spacing
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.typography.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.typography,
                              foregroundColor: AppColor.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              int actTaxId = item.activityTaxId ?? -1;
                              if ((actTaxId == 0 || actTaxId == 1) &&
                                  item.taxId == 0) {
                                String message = actTaxId == 0
                                    ? "يمكن تغيير نضام الجبائي إلى حقيقي لاكن بطلب منذ التأسيس \nأو قبل 01 فيفري من السنة\nأو عند تجاوز سنتين متتاليتين\nعتبة 8.000.000.00 د.ج."
                                    : "يمكن التحويل الى المبسط\nعند تجاوز سنتين متتاليتين\nعتبة 8.000.000.00 د.ج \nأو بطلب قبل 01 فيفري أو منذ التأسيس.";

                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: AppColor.typography
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.info_outline_rounded,
                                              color: AppColor.typography,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "تنبيه هام".tr,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.typography,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            message.tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              height: 1.6,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColor.typography,
                                                    foregroundColor:
                                                        AppColor.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                    int newTaxId = actTaxId == 0
                                                        ? 2
                                                        : 1;
                                                    controller
                                                        .updateTaxIdDirectly(
                                                          newTaxId,
                                                        );
                                                  },
                                                  child: Text(
                                                    "تأكيد التغيير".tr,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: AppColor
                                                        .grey
                                                        .withOpacity(0.1),
                                                    foregroundColor:
                                                        AppColor.typography,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 14,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            15,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () => Get.back(),
                                                  child: Text(
                                                    "إلغاء".tr,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (item.taxId == 2) {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: AppColor.red.withOpacity(
                                                0.1,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.warning_amber_rounded,
                                              color: AppColor.red,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "غير مسموح".tr,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.red,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            "لا يمكن تغيير النظام الجبائي بعد إعتماده."
                                                .tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              height: 1.6,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.red
                                                    .withOpacity(0.1),
                                                foregroundColor: AppColor.red,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 0,
                                              ),
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                "حسنًا".tr,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else if (item.taxId == 1) {
                                Get.dialog(
                                  Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.all(25),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: AppColor.red.withOpacity(
                                                0.1,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.warning_amber_rounded,
                                              color: AppColor.red,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "غير مسموح".tr,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.red,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            "لا يمكن تغيير النظام الجبائي بعد إعتماده."
                                                .tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              height: 1.6,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.red
                                                    .withOpacity(0.1),
                                                foregroundColor: AppColor.red,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                elevation: 0,
                                              ),
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                "حسنًا".tr,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              // else {
                              //   // If there is any other case, we might fallback
                              //   showSnackbar(
                              //     "تنبيه".tr,
                              //     "لا توجد بيانات كافية لتعديل هذا السجل.".tr,
                              //     AppColor.red,
                              //   );
                              // }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.edit_rounded, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "تعديل".tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.red.withOpacity(0.1),
                              foregroundColor: AppColor.red,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: AppColor.red.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColor.red,
                                            size: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "تأكيد الحذف".tr,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.typography,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          "هل أنت متأكد من أنك تريد حذف هذا السجل بشكل نهائي؟".tr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            height: 1.6,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColor.red,
                                                  foregroundColor: AppColor.white,
                                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                  controller.daletedata();
                                                },
                                                child: Text(
                                                  "حذف".tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: AppColor.grey.withOpacity(0.1),
                                                  foregroundColor: AppColor.typography,
                                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                ),
                                                onPressed: () => Get.back(),
                                                child: Text(
                                                  "إلغاء".tr,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "حذف".tr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
    final primaryColor = isPast
        ? Colors.orange.shade700
        : AppColor.primarycolor;
    final bgColor = isPast
        ? Colors.orange.shade50
        : AppColor.primarycolor.withOpacity(0.05);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.typography.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isExpanded
              ? primaryColor.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            // Header
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: bgColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPast
                              ? Icons.event_busy_rounded
                              : Icons.schedule_rounded,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: isPast
                                    ? AppColor.grey
                                    : AppColor.typography,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  "${"الموعد النهائي".tr} : ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.grey.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  widget.date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? -0.5 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColor.grey.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColor.typography.withOpacity(0.6),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Expanded Details
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.typography.withOpacity(0.02),
                  border: Border(
                    top: BorderSide(color: AppColor.grey.withOpacity(0.1)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: AppColor.red.withOpacity(0.8),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "التبعات المترتبة".tr,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.red.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.dec,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.typography,
                        height: 1.6,
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
      ),
    );
  }
}
