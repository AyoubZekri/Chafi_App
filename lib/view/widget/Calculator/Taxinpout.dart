// ignore_for_file: public_member_api_docs, sort_constructors_first
// --- ويدجت مساعدة للعناوين ---
import 'package:flutter/material.dart';

import 'package:chafi/view/widget/Calculator/DateButtonSheep.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

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
  final Function(String)? onPressed;


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
    this.onChanged, this.onPressed,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  Future<void> _openSmartDatePicker() async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SmartDatePickerSheet(),
    );

    if (result != null) {
      widget.controller?.text =
          "${result.year}/${result.month.toString().padLeft(2, '0')}/${result.day.toString().padLeft(2, '0')}";
      widget.onDateSelected?.call(result);
      setState(() {});
    }
  }

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
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37474F),
            ),
          ),
          const SizedBox(height: 12),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(widget.icon, color: Colors.grey.shade600),

                  Expanded(
                    child: AbsorbPointer(
                      absorbing: widget.isDate,
                      child: TextField(
                        controller: widget.controller,
                        onChanged: widget.onChanged,
                        textAlign: widget.isDate
                            ? TextAlign.left
                            : TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontSize:
                              16, // حجم النص أثناء الكتابة → صغّره كما تريد
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
                        keyboardType: widget.isDate
                            ? TextInputType.none
                            : TextInputType.number,
                      ),
                    ),
                  ),
                  if (widget.isDate) const Spacer(),
                  if (widget.isCurrency)
                     Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'DZD'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

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
