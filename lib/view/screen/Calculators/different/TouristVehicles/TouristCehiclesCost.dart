import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/TouristCehiclesController.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Calculator/CustemDeffret.dart';
import '../../../../widget/Text/CustemtextbodyMedium18.dart';

class Touristcehiclescost extends StatefulWidget {
  const Touristcehiclescost({super.key});

  @override
  State<Touristcehiclescost> createState() => _TouristcehiclescostState();
}

class _TouristcehiclescostState extends State<Touristcehiclescost> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<Touristcehiclescontroller>().Back();
        return true;
      },
      child: Scaffold(
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
                  label: Text("إضافة مركبة".tr),
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
                        titleText: "إضافة تفاصيل المركبة".tr,
                        nameLabel: "اسم المركبة".tr,
                        nameHint: "إسم المركبة".tr,
                        icon: Icons.directions_car_outlined,
                        costLabel:
                            Get.find<Touristcehiclescontroller>().type == 2
                            ? "تكلفة الكراء".tr
                            : "تكلفة صيانة المركبة".tr,
                        costHint:
                            Get.find<Touristcehiclescontroller>().type == 2
                            ? "تكلفة الكراء".tr
                            : "تكلفة صيانة المركبة".tr,
                        countLabel: "عدد المركبات".tr,
                        countHint: "عدد المركبات".tr,
                        addText: "إضافة".tr,
                        cancelText: "إلغاء".tr,
                        nameController:
                            Get.find<Touristcehiclescontroller>().nameguidance,
                        costController:
                            Get.find<Touristcehiclescontroller>().costsguidance,
                        countController:
                            Get.find<Touristcehiclescontroller>().countguidance,
                        onPressedBack: () => Navigator.of(context).pop(false),
                        onPressed: () {
                          Get.find<Touristcehiclescontroller>().addGuidance();
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
                  label: Text("الحساب".tr),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Get.find<Touristcehiclescontroller>().calcul();
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("المركبات السياحية".tr),
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
        body: GetBuilder<Touristcehiclescontroller>(
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
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content:
                                  "أضف المركبة مع التكلفة لي يتم حساب مجموع الخصومات "
                                      .tr,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 80),
                                itemCount: controller.gifts.length,
                                itemBuilder: (context, index) {
                                  final gift = controller.gifts[index];

                                  int td = 0;
                                  int tnd = 0;
                                  String taxTextLabel = "";
                                  String totalTextLabel = "";

                                  if (controller.type == 2) {
                                    // Rental
                                    td = gift.cost;
                                    tnd = gift.cost * gift.quantity;
                                    taxTextLabel = "تكلفة الوحدة".tr;
                                    totalTextLabel = "التكلفة الإجمالية".tr;
                                  } else {
                                    // Maintenance
                                    int unitDeductible = gift.cost > 2000000 ? 2000000 : gift.cost;
                                    int unitNonDeductible = gift.cost > 2000000 ? gift.cost - 2000000 : 0;
                                    td = unitDeductible * gift.quantity;
                                    tnd = unitNonDeductible * gift.quantity;
                                    taxTextLabel = "المبلغ القابل لي الخصم".tr;
                                    totalTextLabel = "يضاف لي نتيجة جبائية".tr;
                                  }

                                  return GiftCard(
                                    name: "${gift.name} (${gift.quantity})",
                                    tax: td,
                                    total: tnd,
                                    taxText: taxTextLabel,
                                    totalText: totalTextLabel,
                                    icon: Icons.directions_car,
                                    bgIcon: Icons.directions_car,
                                    onPressed: () {
                                      controller.gifts.removeAt(index);
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
