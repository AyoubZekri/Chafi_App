import 'package:chafi/view/widget/Setting/CustemCardNotification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Setting/Notificationcontroller.dart';
import '../../../core/constant/Colorapp.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    Get.put(NotificationcontrollerImp());
    return GetBuilder<NotificationcontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("الإشعارات".tr)),
          body: Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, i) {
                return Custemcardnotification(
                  title: "تنبيه بي موعد",
                  body: "اخر موعد لي دفع الضريبة 01 جانفي 2025",
                  color2: const Color.fromARGB(194, 255, 153, 0),
                  color: const Color.fromARGB(30, 0, 0, 0),
                  icon: Icons.close,
                  dot: i % 2 == 0 ? true : false,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
