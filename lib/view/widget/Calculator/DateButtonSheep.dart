import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmartDatePickerSheet extends StatefulWidget {
  const SmartDatePickerSheet({super.key});

  @override
  State<SmartDatePickerSheet> createState() => _SmartDatePickerSheetState();
}

class _SmartDatePickerSheetState extends State<SmartDatePickerSheet>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  int selectedDay = DateTime.now().day;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  final now = DateTime.now();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  int get daysInMonth => DateTime(selectedYear, selectedMonth + 1, 0).day;

  void submit() {
    Navigator.pop(context, DateTime(selectedYear, selectedMonth, selectedDay));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        children: [
          /// Handle
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// Tabs
          TabBar(
            controller: tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "اليوم".tr),
              Tab(text: "الشهر".tr),
              Tab(text: "السنة".tr),
            ],
          ),

          Expanded(
            child: Container(
              child: TabBarView(
                controller: tabController,
                children: [buildDays(), buildMonths(), buildYears()],
              ),
            ),
          ),

          /// Confirm Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.typography,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                "تأكيد".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= DAY =================
  Widget buildDays() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daysInMonth,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (_, i) {
        final day = i + 1;

        // يوم بعد اليوم الحالي ممنوع
        bool disabled =
            selectedYear == now.year &&
            selectedMonth == now.month &&
            day > now.day;

        return DayCell(
          value: day,
          selected: selectedDay == day,
          disabled: disabled,
          onTap: disabled ? null : () => setState(() => selectedDay = day),
        );
      },
    );
  }

  /// ================= MONTH =================
  Widget buildMonths() {
    final months = [
      "يناير".tr,
      "فبراير".tr,
      "مارس".tr,
      "أفريل".tr,
      "ماي".tr,
      "جوان".tr,
      "جويلية".tr,
      "أوت".tr,
      "سبتمبر".tr,
      "أكتوبر".tr,
      "نوفمبر".tr,
      "ديسمبر".tr,
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 12,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (_, i) {
        final month = i + 1;

        // الشهر بعد الشهر الحالي ممنوع إذا السنة الحالية
        bool disabled = selectedYear == now.year && month > now.month;

        return MonthCell(
          text: months[i],
          selected: selectedMonth == month,
          disabled: disabled,
          onTap: disabled ? null : () => setState(() => selectedMonth = month),
        );
      },
    );
  }

  /// ================= YEAR =================
  Widget buildYears() {
    final startYear = 1970;
    final endYear = now.year;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: endYear - startYear + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (_, i) {
        final year = startYear + i;

        // أي سنة بعد اليوم الحالي ممنوع
        bool disabled = year > now.year;

        return YearCell(
          value: year,
          selected: selectedYear == year,
          disabled: disabled,
          onTap: disabled ? null : () => setState(() => selectedYear = year),
        );
      },
    );
  }
}

/// ================= DAY CELL =================
class DayCell extends StatelessWidget {
  final int value;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;

  const DayCell({
    super.key,
    required this.value,
    required this.selected,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = c.maxWidth * 0.8;

        return InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: disabled ? null : onTap,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? Colors.black : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: FittedBox(
                child: Text(
                  "$value",
                  style: TextStyle(
                    fontSize: size * 0.42,
                    fontWeight: FontWeight.w600,
                    color: disabled
                        ? Colors.grey
                        : selected
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ================= MONTH CELL =================
class MonthCell extends StatelessWidget {
  final String text;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;

  const MonthCell({
    super.key,
    required this.text,
    required this.selected,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabled
                ? Colors.grey
                : selected
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}

/// ================= YEAR CELL =================
class YearCell extends StatelessWidget {
  final int value;
  final bool selected;
  final bool disabled;
  final VoidCallback? onTap;

  const YearCell({
    super.key,
    required this.value,
    required this.selected,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          "$value",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabled
                ? Colors.grey
                : selected
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
}
