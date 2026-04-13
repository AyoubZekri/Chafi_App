import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Setting/ExternallinksController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Setting/CustemCardExternallinks.dart';

class Externallinks extends StatefulWidget {
  const Externallinks({super.key});

  @override
  State<Externallinks> createState() => _ExternallinksState();
}

class _ExternallinksState extends State<Externallinks> {
  final controller = Get.put(Externallinkscontroller());

  @override
  Widget build(BuildContext context) {
    Get.put(Externallinkscontroller());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("روابط خارجية".tr)),
      body: GetBuilder<Externallinkscontroller>(
        builder: (controller) {
          return RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData(); // دالة إعادة جلب البيانات
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Handlingview(
                statusrequest: controller.statusrequest,
                widget: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, i) {
                    final item = controller.data[i];
                    return Custemcardexternallinks(
                      body: item.localizedName,
                      color: const Color.fromARGB(30, 0, 0, 0),
                      ontap: () {
                        controller.openUrl(item.indexLink ?? "");
                      },
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
