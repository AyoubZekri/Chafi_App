import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';

class Textfildtaxlastyaer extends StatelessWidget {
  final TextEditingController? myController;
  final TextInputType? keyboardType;
  final String hint;
  final IconData iconData;

  const Textfildtaxlastyaer({
    super.key,
    this.myController,
    this.keyboardType,
    required this.hint, required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.typography,
                borderRadius: BorderRadius.circular(12),
              ),
              child:  Icon(
                iconData,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // حقل البحث
          Expanded(
            child: TextField(
              controller: myController,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
