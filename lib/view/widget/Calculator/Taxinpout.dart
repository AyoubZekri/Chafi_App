// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../core/constant/extension.dart';
import 'package:chafi/view/widget/Calculator/DateButtonSheep.dart';

// =======================
// نوع الفورمات
// =======================
enum DateFormatType { year, yearMonth, full }

// =======================
// Header
// =======================
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.typography, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

// =======================
// Input Field
// =======================
class CustomInputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final String placeholder;
  final bool isCurrency;
  final bool isDate;
  final String? errorText;
  final TextEditingController? controller;
  final Function(DateTime)? onDateSelected;
  final Function(String)? onChanged;

  // الجديد
  final DateFormatType dateFormatType;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.icon,
    this.placeholder = '0.00',
    this.isCurrency = false,
    this.isDate = false,
    this.errorText,
    this.controller,
    this.onDateSelected,
    this.onChanged,
    this.dateFormatType = DateFormatType.full,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  // =======================
  // فتح Date Picker
  // =======================
  Future<void> _openSmartDatePicker() async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SmartDatePickerSheet(),
    );

    if (result != null) {
      widget.controller?.text = _formatDate(result);
      widget.onDateSelected?.call(result);
      setState(() {});
    }
  }

  // =======================
  // فورمات التاريخ
  // =======================
  String _formatDate(DateTime date) {
    switch (widget.dateFormatType) {
      case DateFormatType.year:
        return "${date.year}";
      case DateFormatType.yearMonth:
        return "${date.year}/${date.month.toString().padLeft(2, '0')}";
      case DateFormatType.full:
        return "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}";
    }
  }

  // =======================
  // Currency format
  // =======================
  @override
  void initState() {
    super.initState();

    if (widget.isCurrency && widget.controller != null) {
      widget.controller!.addListener(_formatCurrency);
    }
  }

  void _formatCurrency() {
    final controller = widget.controller;
    if (controller == null) return;

    String clean = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = clean.formatCustom();

    if (controller.text != formatted) {
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  // =======================
  // UI
  // =======================
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37474F),
            ),
          ),

          const SizedBox(height: 12),

          // Input
          InkWell(
            onTap: widget.isDate ? _openSmartDatePicker : null,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.grey.shade600),

                  Expanded(
                    child: AbsorbPointer(
                      absorbing: widget.isDate,
                      child: TextField(
                        readOnly: widget.isDate,
                        controller: widget.controller,
                        onChanged: widget.onChanged,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: widget.isDate
                            ? TextInputType.none
                            : TextInputType.number,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: widget.placeholder,
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (widget.isCurrency)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'DZD'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Error
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                widget.errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
