import 'package:chafi/core/class/handlingview.dart';
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
  final controller = Get.put(Notificationcontroller());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Notificationcontroller>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("الإشعارات".tr)),
          body: RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData(); // دالة إعادة جلب البيانات
            },
            child: Handlingview(
              statusrequest: controller.statusrequest,
              title: "لا توجد إشعارات حاليا".tr,
              widget: Container(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, i) {
                    final item = controller.data[i];
                    return Custemcardnotification(
                      title: item.localizedtitle,
                      body: item.localizedcontent,
                      color2: item.typeNotification == 0
                          ? Color.fromARGB(194, 255, 153, 0)
                          : item.typeNotification == 1
                          ? Color.fromARGB(255, 0, 123, 255)
                          : item.typeNotification == 2
                          ? Color.fromARGB(255, 0, 200, 0)
                          : item.typeNotification == 3
                          ? Color.fromARGB(255, 220, 0, 0)
                          : item.typeNotification == 4
                          ? Color.fromARGB(255, 128, 0, 128)
                          : Color.fromARGB(255, 0, 123, 255),
                      color: const Color.fromARGB(30, 0, 0, 0),
                      icon: item.typeNotification == 0
                          ? Icons.notification_important
                          : item.typeNotification == 1
                          ? Icons.update
                          : item.typeNotification == 2
                          ? Icons.calendar_today
                          : item.typeNotification == 3
                          ? Icons.campaign
                          : item.typeNotification == 4
                          ? Icons.fiber_new
                          : Icons.notifications,
                      dot: item.isread == 0 ? true : false,
                      ontap: () {
                        controller.isRead(item.id);
                        Get.defaultDialog(
                          title: item.localizedtitle,
                          titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.black,
                            fontSize: 20,
                          ),
                          radius: 20,
                          middleText: item.localizedcontent,
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
                      },
                      ontap2: () {
                        controller.deletdata(item.id);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
