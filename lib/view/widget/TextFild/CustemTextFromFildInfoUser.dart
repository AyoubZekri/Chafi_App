import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';

class CustemtextfromfildInfoUser extends StatelessWidget {
  final String hintText;
  final bool enabled;
  // ignore: non_constant_identifier_names
  final TextEditingController? myController;
  final TextInputType? keyboardType;
  final bool? obscureText;
  const CustemtextfromfildInfoUser({
    super.key,
    required this.hintText,
    this.myController,
    this.keyboardType,
    this.obscureText,
    required this.enabled,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            obscureText: obscureText == null || obscureText == false
                ? false
                : true,
            controller: myController,
            keyboardType: keyboardType,
            
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
            decoration: InputDecoration(
              enabled: enabled,
              // labelText: label,
              // labelStyle: TextStyle(
              //   fontSize: 26,
              //   fontWeight: FontWeight.bold,
              //   color: Colors.grey[700],
              // ),
              prefixIcon: Icon(Icons.person, color: AppColor.grey),
              // suffixIcon: Icon(Icons.person),
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.grey,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
