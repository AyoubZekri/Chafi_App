import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/Calculators/bonusesandcompensationcontroller.dart';
import '../../../../../core/constant/Colorapp.dart';
import '../../../../widget/Button/CustemSuberButton.dart';
import '../../../../widget/Calculator/PinaltyDitails.dart';

class Showvaluo extends StatefulWidget {
  const Showvaluo({super.key});

  @override
  State<Showvaluo> createState() => _ShowvaluoState();
}

class _ShowvaluoState extends State<Showvaluo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<bonusesandcompensationcontroller>().backFromShowvaluo();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("العلوات وتعويضات".tr),
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),
        body: GetBuilder<bonusesandcompensationcontroller>(
          builder: (controller) {
            return Container(
              color: AppColor.typography,
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  child: Container(
                    color: AppColor.white,
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      children: [
                        const SizedBox(height: 10),

                        /// عنوان القسم
                        SectionHeader(
                          icon: Icons.gavel_outlined,
                          title: "تفاصيل العلوات وتعويضات".tr,
                        ),

                        const SizedBox(height: 20),

                        PenaltyCard(
                          icon: Icons.account_balance_wallet_outlined,
                          title: "الأجر القاعدي".tr,
                          subtitle: "الأجر الأساسي".tr,
                          amount: controller.Basicwage.toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          icon: Icons.location_on_outlined,
                          title: "علاوة المنطقة".tr,
                          subtitle: "تعويض مرتبط بالمنطقة الجغرافية".tr,
                          amount: controller.zoon
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        PenaltyCard(
                          icon: Icons.percent_outlined,
                          title: "الاشتراك".tr,
                          subtitle: "الخاصة بالضمان الاجتماعي".tr,
                          amount: controller.person9
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.payments_outlined,
                          title: "الدخل الخاضع".tr,
                          subtitle: "الخاضع للضريبة بعد الإضافات".tr,
                          amount: controller.grossincome
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.trending_down_outlined,
                          title: "التخفيض الأول".tr,
                          subtitle: "تخفيض 40%".tr,
                          amount: controller.discount1
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.volunteer_activism_outlined,
                          title: "التخفيض الثاني".tr,
                          subtitle: controller.personscondition == 6
                              ? "دخل الضعيف".tr
                              : "لذوي الاحتياجات والمتقاعدين".tr,
                          amount: controller.discount2
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 24),

                        /// المجموع الكلي
                        TotalAmountCard(total: controller.discount2.toInt()),

                        const SizedBox(height: 30),
                        Custemsuberbutton(
                          content: "عرض قسيمة الراتب".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.6),
                              builder: (_) => const SalarySlipDialog(),
                            );
                          },
                        ),
                        const SizedBox(height: 20),

                        /// زر إنهاء
                        Custemsuberbutton(
                          content: "إنهاء".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            controller.resetAll();
                          },
                        ),
                      ],
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

class SalarySlipDialog extends StatelessWidget {
  const SalarySlipDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.acteve,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 750),
        decoration: BoxDecoration(
          color: const Color(0xfff6f8f6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            /// HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.payments, color: AppColor.typography),
                      SizedBox(width: 8),
                      Text(
                        "Bulletin de Paie",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
            ),

            GetBuilder<bonusesandcompensationcontroller>(
              builder: (Controller) {
                List<DataRow> rows = [];
                rows.add(
                  DataRow(
                    cells: [
                      const DataCell(Text("1")),
                      const DataCell(Text("الأجر القاعدي")),
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      DataCell(
                        Text(Controller.Basicwage.toInt().formatCustomint()),
                      ),
                      const DataCell(Text("")),
                    ],
                  ),
                );

                /// BONUSES
                Controller.groupedData.forEach((cat, bonuses) {
                  for (var bonus in bonuses) {
                    if (Controller.selectedGroups[cat]?.contains(bonus.id) ??
                        false) {
                      final controller =
                          Controller.valueControllersGroups[cat]?[bonus.id];

                      rows.add(
                        DataRow(
                          cells: [
                            DataCell(Text((bonus.id + 1).toString())),
                            DataCell(Text(bonus.localizedName)),
                            const DataCell(Text("")),
                            const DataCell(Text("")),
                            DataCell(Text(controller!.text)),
                            DataCell(Text("")),
                          ],
                        ),
                      );
                    }
                  }
                });

                rows.add(
                  DataRow(
                    cells: [
                      const DataCell(Text("1")),
                      const DataCell(Text("الضمان الاجتماعي")),
                      DataCell(
                        Text(
                          Controller.sumgroub1
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                      ),
                      const DataCell(Text("9,00")),
                      const DataCell(Text("")),
                      DataCell(
                        Text(
                          Controller.person9
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                      ),
                    ],
                  ),
                );

                rows.add(
                  DataRow(
                    cells: [
                      const DataCell(Text("1")),
                      const DataCell(Text("I.R.G")),
                      DataCell(
                        Text(
                          Controller.grossincome
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                      ),
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      DataCell(Text("")),
                    ],
                  ),
                );

                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 20,
                            headingRowColor: MaterialStatePropertyAll(
                              AppColor.typography.withOpacity(0.1),
                            ),
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: AppColor.typography.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            columns: const [
                              DataColumn(label: Text("Code")),
                              DataColumn(label: Text("Libellé")),
                              DataColumn(label: Text("Nombre")),
                              DataColumn(label: Text("Taux")),
                              DataColumn(label: Text("Gain")),
                              DataColumn(label: Text("Retenue")),
                            ],
                            rows: rows,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// TOTALS
                      Row(
                        children: [
                          Expanded(
                            child: _totalCard(
                              "Totaux Gains",
                              Controller.total
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                              false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _totalCard(
                              "Totaux Retenues",
                              Controller.person9
                                  .toInt()
                                  .formatCustomint()
                                  .toString(),
                              true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// NET
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.typography.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColor.typography,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Net à Payer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.typography,
                              ),
                            ),
                            Text(
                              "${(Controller.total - Controller.person9).toInt().formatCustomint()} DZD",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColor.typography,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static Widget _totalCard(String title, String value, bool isRed) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isRed ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
