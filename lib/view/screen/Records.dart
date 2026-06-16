import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Recorde/RecordsController.dart';
import '../../core/class/handlingview.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/Records/CustemBusinessCard.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  late RecordscontrollerImp controller;

  @override
  void initState() {
    controller = Get.put(RecordscontrollerImp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("سجلاتي".tr)),
      // ── Premium FAB ──
      floatingActionButton: _buildPremiumFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: Obx(() {
        return RefreshIndicator(
          color: AppColor.typography,
          onRefresh: () async {
            await controller.getData();
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: controller.data.isEmpty ? 2 : controller.data.length + 1,
            itemBuilder: (context, index) {
              // ── 0: Subtitle ──
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Text(
                    "90".tr,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                      color: AppColor.grey,
                    ),
                  ),
                );
              }

              // ── Empty state ──
              if (controller.data.isEmpty) {
                return SizedBox(
                  height: 500,
                  child: Handlingview(
                    statusrequest: controller.statusrequest.value,
                    widget: const SizedBox(),
                  ),
                );
              }

              // ── Records ──
              final item = controller.data[index - 1];

              return BusinessCard(
                active: item.activityName == null
                    ? item.activitSpecial == 1
                          ? "شركة مدنية".tr
                          : item.activitSpecial == 3
                          ? "تعاونيات الفنية والتقليدية".tr
                          : "شركة أخرى".tr
                    : item.localizedActivityName,
                condition: 1,
                ontap: () {
                  controller.gotoInfoRecord(
                    item.id,
                    item.taxId == 3 ? 0 : item.taxId,
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }

  /// Premium floating action button with gradient + gold accent
  Widget _buildPremiumFab() {
    return GestureDetector(
      onTap: () => controller.gotoMypath(),
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF034D82), Color(0xFF0572B9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.amber.shade400.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF034D82).withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: Colors.amber.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
      ),
    );
  }
}
