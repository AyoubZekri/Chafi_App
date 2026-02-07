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
  @override
  Widget build(BuildContext context) {
    Get.put(Notificationcontroller());
    return GetBuilder<Notificationcontroller>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("الإشعارات".tr)),
          body: Handlingview(
            statusrequest: controller.statusrequest,
            title: "لا توجد إشعارات حاليا",
            widget: Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  final item = controller.data[i];
                  return Custemcardnotification(
                    title: item.localizedtitle,
                    body: item.localizedcontent,
                    color2: const Color.fromARGB(194, 255, 153, 0),
                    color: const Color.fromARGB(30, 0, 0, 0),
                    icon: Icons.close,
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
                              "حسنًا",
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
        );
      },
    );
  }
}
