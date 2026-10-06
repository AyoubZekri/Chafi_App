import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/TaxFiles/TaxFilesController.dart';
import '../../../core/class/handlingview.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Button/CustoumButtonCard.dart';

/// ملفات "جبايتك": في شريط التنقل (كل المواد)،
/// أو من "البحث في الجباية" في الرئيسية (المواد المقننة فقط)
class TaxFiles extends StatelessWidget {
  final bool codifiedOnly;

  const TaxFiles({super.key, this.codifiedOnly = false});

  @override
  Widget build(BuildContext context) {
    Get.put(TaxFilesController());

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(codifiedOnly ? "البحث في الجباية".tr : "78".tr),
      ),
      body: GetBuilder<TaxFilesController>(
        builder: (controller) {
          return RefreshIndicator(
            color: AppColor.typography,
            onRefresh: controller.viewdata,
            child: Handlingview(
              statusrequest: controller.statusrequest,
              widget: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                itemCount: controller.data.length,
                itemBuilder: (context, i) {
                  final item = controller.data[i];
                  return Custoumbuttoncard(
                    title: item.localizedTitle,
                    description: item.year == null
                        ? "عرض المواد".tr
                        : '${"إصدار".tr} ${item.year}',
                    onTap: () => controller.openFile(
                      item,
                      codifiedOnly: codifiedOnly,
                    ),
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
