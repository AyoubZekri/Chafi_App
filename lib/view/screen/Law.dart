import 'package:chafi/LinkApi.dart';
import 'package:chafi/controller/LawController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/handlingview.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/Button/CustoumButtonCard.dart';
import 'pdf.dart';

class Law extends StatefulWidget {
  const Law({super.key});

  @override
  State<Law> createState() => _LawState();
}

class _LawState extends State<Law> {
  final Lawcontroller controller = Get.put(Lawcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("78".tr)),
      body: GetBuilder<Lawcontroller>(
        builder: (controller) {
          return RefreshIndicator(
            color: AppColor.typography,
            onRefresh: () async {
              await controller.getData(); // دالة إعادة جلب البيانات
            },
            child: Handlingview(
              statusrequest: controller.statusrequest,
              widget: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  final item = controller.data[i];
                  return Custoumbuttoncard(
                    title: item.localizedName,
                    description:
                       '${"خرج في".tr} ${item.updatedAt.toString().substring(0, 4)}',
                    onTap: () {
                      Get.to(
                        () => PdfSearchPage(
                          url: "${Applink.image}${item.pdf}",
                          initialPage: 1,
                        ),
                      );
                    },
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
