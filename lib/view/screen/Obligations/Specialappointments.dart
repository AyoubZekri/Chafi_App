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
  @override
  Widget build(BuildContext context) {
    AppointmentscommitmentscontrollerImp controller = Get.put(
      AppointmentscommitmentscontrollerImp(),
    );
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("المواعيد والإلتزمات".tr)),
      body: GetBuilder<AppointmentscommitmentscontrollerImp>(
        builder: (_) {
          return Handlingview(
            statusrequest: controller.statusrequest,
            widget: Container(
              child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  return DeadlineAlertCard(
                    title: controller.data[i].declaration,
                    deadline: controller.data[i].deadline,
                    consequences: controller.data[i].dependencies,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
