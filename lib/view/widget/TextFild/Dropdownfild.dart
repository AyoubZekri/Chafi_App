import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/Colorapp.dart';

class Dropdownfild<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hintText;
  final void Function(T?) onChanged;

  /// أيقونة الحقل (افتراضياً أيقونة الموقع كما في حقل الولاية)
  final IconData icon;

  /// عدد أسطر النص المختار والتلميح (1 = سطر واحد مع "...")
  final int maxLines;

  /// حجم خط التلميح والنص المختار
  final double fontSize;

  /// رسالة خطأ تظهر تحت الحقل مع إطار أحمر (حقل إجباري لم يُملأ)
  final String? errorText;

  const Dropdownfild({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
    this.icon = Icons.location_on,
    this.maxLines = 1,
    this.fontSize = 18,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          margin: EdgeInsets.only(top: 10, bottom: hasError ? 4 : 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: hasError ? Border.all(color: Colors.red, width: 1.2) : null,
            boxShadow: [
              BoxShadow(
                color: AppColor.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(icon, color: hasError ? Colors.red : AppColor.grey),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<T>(
                    isExpanded: true,
                    hint: Text(
                      hintText,
                      maxLines: maxLines,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColor.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    selectedItemBuilder: (context) {
                      return items.map((item) {
                        final text = (item.child as Text).data ?? '';
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                text,
                                maxLines: maxLines,
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },

                    items: items.map((item) {
                      final text = (item.child as Text).data ?? '';
                      return DropdownMenuItem<T>(
                        value: item.value,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              size: 18,
                              color: AppColor.grey,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                text,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    value: value,
                    onChanged: onChanged,

                    // ارتفاع أكبر للحقل عندما يسمح بسطرين
                    buttonStyleData: maxLines > 1
                        ? ButtonStyleData(height: fontSize * 1.35 * maxLines + 12)
                        : const ButtonStyleData(),
                    menuItemStyleData:
                        MenuItemStyleData(height: maxLines > 1 ? 60 : 48),

                    /// 🔹 ستايل القائمة
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 203, 201, 201),
                        ),
                      ),
                      elevation: 8,
                    ),

                    /// 🔹 أيقونة السهم
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 24,
                      iconEnabledColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 12, left: 12),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
