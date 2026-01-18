import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';
import '../Text/CustemheadlineMedium.dart';

class Custembuttonprimary extends StatelessWidget {
  final String content;
  final void Function()? onPressed;
  const Custembuttonprimary({super.key, required this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 260,
      decoration: BoxDecoration(
        color: AppColor.typography,
        borderRadius: BorderRadius.circular(15),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
        child: Custemheadlinemedium(content: content),
      ),
    );
  }
}
