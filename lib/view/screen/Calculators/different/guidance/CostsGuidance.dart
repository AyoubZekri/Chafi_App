import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/Costsguidancecontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Calculator/CustemDeffret.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Costsguidance extends StatefulWidget {
  const Costsguidance({super.key});

  @override
  State<Costsguidance> createState() => _CostsguidanceState();
}

class _CostsguidanceState extends State<Costsguidance> {
  final controller = Get.put(Costsguidancecontroller());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.Back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("gifts".tr),
          titleTextStyle: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: const IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: AppColor.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text("add_gift".tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.typography,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await showDialog<bool>(
                      context: context,
                      builder: (_) => AddGiftDialog(
                        titleText: "add_gift_details".tr,
                        nameLabel: "gift_name".tr,
                        nameHint: "gift_name_hint".tr,
                        costLabel: "gift_cost".tr,
                        costHint: "gift_cost_hint".tr,
                        addText: "add".tr,
                        cancelText: "cancel".tr,
                        nameController: controller.nameguidance,
                        costController: controller.costsguidance,
                        onPressedBack: () => Navigator.of(context).pop(false),
                        onPressed: () {
                          controller.addGuidance();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.calculate),
                  label: Text("calculate".tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    controller.calcul();
                  },
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<Costsguidancecontroller>(
          builder: (controller) {
            return Container(
              color: AppColor.typography,
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  child: Container(
                    color: AppColor.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        child: Column(
                          children: [
                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content: "add_gifts_description".tr,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: controller.gifts.length,
                                itemBuilder: (context, index) {
                                  final gift = controller.gifts.entries
                                      .toList()[index];

                                  return GiftCard(
                                    name: gift.key,
                                    tax: gift.value > 100000
                                        ? 100000
                                        : gift.value,
                                    total: controller.costsguidances(
                                      gift.value,
                                    ),
                                    taxText: "deductible_amount".tr,
                                    totalText: "added_to_tax_result".tr,
                                    onPressed: () {
                                      controller.gifts.remove(gift.key);
                                      controller.update();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
