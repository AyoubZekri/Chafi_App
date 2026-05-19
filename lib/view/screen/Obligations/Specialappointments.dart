import 'package:chafi/controller/AppointmentscommitmentsController.dart';
import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../widget/Obligations/DeadlineAlertCard.dart';

class Specialappointments extends StatefulWidget {
  const Specialappointments({super.key});

  @override
  State<Specialappointments> createState() => _SpecialappointmentsState();
}

class _SpecialappointmentsState extends State<Specialappointments> {
  final controller = Get.put(AppointmentscommitmentscontrollerImp());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("المواعيد والإلتزمات".tr)),
      body: GetBuilder<AppointmentscommitmentscontrollerImp>(
        builder: (_) {
          return RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData(); // دالة إعادة جلب البيانات
            },
            child: Handlingview(
              statusrequest: controller.statusrequest,
              widget: Container(
                child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, i) {
                    return DeadlineAlertCard(
                      title: controller.data[i].declaration,
                      dateText: controller.data[i].deadline
                          .toString()
                          .substring(5, 10),
                      subtitleLabel: "التبعات المترتبة",
                      subtitleValue: controller.data[i].dependencies,
                      isOverdue: () {
                        try {
                          String mmdd = controller.data[i].deadline.toString().substring(5, 10);
                          List<String> parts = mmdd.split('-');
                          int month = int.parse(parts[0]);
                          int day = int.parse(parts[1]);
                          DateTime now = DateTime.now();
                          DateTime deadlineDate = DateTime(now.year, month, day);
                          // قارن التاريخ فقط (بدون الوقت) لضمان الدقة
                          DateTime today = DateTime(now.year, now.month, now.day);
                          return deadlineDate.isBefore(today);
                        } catch (e) {
                          return false;
                        }
                      }(),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
