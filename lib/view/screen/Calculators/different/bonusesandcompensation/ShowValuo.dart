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
          title: Text("bonuses_compensations".tr),
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
                          title: "bonus_details".tr,
                        ),

                        const SizedBox(height: 20),

                        PenaltyCard(
                          icon: Icons.account_balance_wallet_outlined,
                          title: "basic_wage".tr,
                          subtitle: "base_salary".tr,
                          amount: controller.Basicwage.toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),
                        PenaltyCard(
                          icon: Icons.location_on_outlined,
                          title: "zone_bonus".tr,
                          subtitle: "zone_bonus_desc".tr,
                          amount: controller.zoon
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        PenaltyCard(
                          icon: Icons.percent_outlined,
                          title: "social_security".tr,
                          subtitle: "social_security_desc".tr,
                          amount: controller.person9
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),

                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.payments_outlined,
                          title: "taxable_income".tr,
                          subtitle: "taxable_income_desc".tr,
                          amount: controller.grossincome
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.trending_down_outlined,
                          title: "first_discount".tr,
                          subtitle: "first_discount_desc".tr,
                          amount: controller.discount1
                              .toInt()
                              .formatCustomint()
                              .toString(),
                        ),
                        const SizedBox(height: 12),

                        /// غرامة التأخير
                        PenaltyCard(
                          icon: Icons.volunteer_activism_outlined,
                          title: "second_discount".tr,
                          subtitle: controller.personscondition == 6
                              ? "second_discount_desc_low_income".tr
                              : "second_discount_desc_special".tr,
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
                          content: "show_salary_slip".tr,
                          color: AppColor.typography,
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.6),
                              builder: (_) => const SalarySlipDialog(),
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        /// زر إنهاء
                        Custemsuberbutton(
                          content: "finish".tr,
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
      backgroundColor: AppColor.typography,
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
            // HEADER
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payments, color: AppColor.brand),
                      const SizedBox(width: 8),
                      Text(
                        "salary_slip".tr,
                        style: const TextStyle(
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

                // Base Salary
                rows.add(
                  DataRow(
                    cells: [
                      const DataCell(Text("1")),
                      DataCell(Text("base_salary".tr)),
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      DataCell(
                        Text(Controller.Basicwage.toInt().formatCustomint()),
                      ),
                      const DataCell(Text("")),
                    ],
                  ),
                );

                // Bonuses
                int index = 2;

                Controller.groupedData.forEach((cat, bonuses) {
                  for (var bonus in bonuses) {
                    if (Controller.selectedGroups[cat]?.contains(bonus.id) ??
                        false) {
                      final controller =
                          Controller.valueControllersGroups[cat]?[bonus.id];

                      rows.add(
                        DataRow(
                          cells: [
                            DataCell(Text(index.toString())),
                            DataCell(Text(bonus.localizedName)),
                            const DataCell(Text("")),
                            const DataCell(Text("")),
                            DataCell(Text(controller!.text)),
                            const DataCell(Text("")),
                          ],
                        ),
                      );

                      index++; // يزيد مع كل صف
                    }
                  }
                }); // Social Security
                rows.add(
                  DataRow(
                    cells: [
                      DataCell(Text("${Controller.groupedData.length + 1}")),
                      DataCell(Text("social_security".tr)),
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

                // IRG
                rows.add(
                  DataRow(
                    cells: [
                      DataCell(Text("${Controller.groupedData.length + 2}")),
                      DataCell(Text("irg".tr)),
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
                      const DataCell(Text("")),
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
                              AppColor.typography,
                            ),
                            dataTextStyle: TextStyle(color: AppColor.brand),

                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: AppColor.typography.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            columns: [
                              DataColumn(
                                label: Text(
                                  "code".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "label".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "number".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "rate".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "gain".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "deduction".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            rows: rows,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // TOTALS
                      Row(
                        children: [
                          Expanded(
                            child: _totalCard(
                              "total_gains".tr,
                              Controller.total.toInt().formatCustomint(),
                              false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _totalCard(
                              "total_deductions".tr,
                              Controller.person9.toInt().formatCustomint(),
                              true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // NET
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.brand.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColor.brand, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "net_to_pay".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.brand,
                              ),
                            ),
                            Text(
                              "${(Controller.total - Controller.person9).toInt().formatCustomint()} DZD",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColor.brand,
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
