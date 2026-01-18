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
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("المواعيد والإلتزمات".tr)),
      body: Container(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, i) {
            return DeadlineAlertCard(
              title: 'تصريح 50ج لكل شهر',
              deadline: '20/12/2025',
              consequences: '500ج لكل إلتزام',
            );
          },
        ),
      ),
    );
  }
}
