import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/Colorapp.dart';

class Dropdownfild<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String hintText;
  final void Function(T?) onChanged;

  const Dropdownfild({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          Icon(Icons.location_on, color: AppColor.grey),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 18,
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
                            style: TextStyle(
                              fontSize: 18,
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
                        Text(text, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }).toList(),

                value: value,
                onChanged: onChanged,

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
    );
  }
}
