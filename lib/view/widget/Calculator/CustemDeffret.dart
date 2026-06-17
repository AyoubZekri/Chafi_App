import 'package:chafi/core/constant/extension.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../core/functions/valiedinput.dart';

/// =====================================================
/// GIFT CARD
/// =====================================================

class GiftCard extends StatelessWidget {
  final String name;
  final int tax;
  final int total;
  final String taxText;
  final String totalText;
  final IconData? icon;
  final IconData? bgIcon;
  final void Function()? onPressed;

  const GiftCard({
    super.key,
    required this.name,
    required this.tax,
    required this.total,
    required this.taxText,
    required this.totalText,
    this.icon,
    this.bgIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1E1E), const Color(0xFF2C2C2C)]
              : [Colors.white, const Color(0xFFF8F9FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: isDark ? Colors.black45 : Colors.grey.withOpacity(0.15),
        //     blurRadius: 15,
        //     offset: const Offset(0, 8),
        //   ),
        // ],
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                bgIcon ?? Icons.card_giftcard,
                size: 100,
                color: isDark
                    ? Colors.white.withOpacity(0.03)
                    : AppColor.typography.withOpacity(0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.typography.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon ?? Icons.redeem,
                          color: AppColor.typography,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : Colors.black87,
                            fontFamily: "Almiri",
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onPressed,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    height: 1,
                    thickness: 1,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailColumn(
                          title: taxText,
                          amount: tax,
                          icon: Icons.check_circle_outline,
                          iconColor: Colors.green,
                          isDark: isDark,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: isDark ? Colors.grey[800] : Colors.grey[300],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDetailColumn(
                          title: totalText,
                          amount: total,
                          icon: Icons.warning_amber_rounded,
                          iconColor: Colors.orange,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn({
    required String title,
    required int amount,
    required IconData icon,
    required Color iconColor,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${amount.formatCustomint()} DA',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}

/// =====================================================
/// ADD DIALOG
/// =====================================================

class AddGiftDialog extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController costController;
  final TextEditingController? countController;
  final void Function()? onPressedBack;
  final void Function()? onPressed;

  // النصوص تمرر من برا
  final String titleText;
  final String nameLabel;
  final String nameHint;
  final String costLabel;
  final String costHint;
  final String? countLabel;
  final String? countHint;
  final String addText;
  final String cancelText;
  final IconData icon;

  const AddGiftDialog({
    super.key,
    required this.nameController,
    required this.costController,
    this.onPressedBack,
    this.onPressed,
    required this.titleText,
    required this.nameLabel,
    required this.nameHint,
    required this.costLabel,
    required this.costHint,
    this.countLabel,
    this.countHint,
    this.countController,
    required this.addText,
    required this.cancelText,
    this.icon = Icons.card_giftcard,
  });

  @override
  State<AddGiftDialog> createState() => _AddGiftDialogState();
}

class _AddGiftDialogState extends State<AddGiftDialog> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                widget.titleText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Inputs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      context,
                      widget.nameLabel,
                      widget.nameHint,
                      widget.icon,
                      false,
                      widget.nameController,
                      (value) => validInput(value!, 20, 3, "Text"),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      widget.costLabel,
                      widget.costHint,
                      Icons.payments,
                      true,
                      widget.costController,
                      (value) => validInput(
                        value!.replaceAll(RegExp(r'[^0-9]'), ''),
                        20,
                        3,
                        "int",
                      ),
                    ),
                    if (widget.countController != null) ...[
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        widget.countLabel ?? "",
                        widget.countHint ?? "",
                        Icons.numbers,
                        true,
                        widget.countController!,
                        (value) => validInput(
                          value!.replaceAll(RegExp(r'[^0-9]'), ''),
                          20,
                          1,
                          "int",
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: Text(widget.addText),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.typography,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onPressed?.call();
                          Navigator.of(context).pop(true);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close),
                      label: Text(widget.cancelText),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: widget.onPressedBack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String placeholder,
    IconData icon,
    bool isNumber,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[300]
                : Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          validator: validator,
          style: const TextStyle(fontSize: 14),

          onChanged: isNumber
              ? (value) {
                  final formatted = value.formatCustom();

                  controller.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              : null,

          decoration: InputDecoration(
            hintText: placeholder,
            errorStyle: const TextStyle(fontSize: 13, height: 2),
            hintStyle: const TextStyle(fontSize: 13),
            prefixIcon: Icon(icon, size: 20, color: Colors.grey[500]),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.typography,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
