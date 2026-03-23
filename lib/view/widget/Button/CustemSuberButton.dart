import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';

import '../Text/CustemheadlineMedium.dart';

class Custemsuberbutton extends StatelessWidget {
  final String content;
  final Color color;
  final Color color2;
  final void Function()? onPressed;
  final bool laoding;

  const Custemsuberbutton({
    super.key,
    required this.content,
    this.onPressed,
    required this.color,
    this.color2 = AppColor.white,
    this.laoding = false,
  });

  @override
  Widget build(BuildContext context) {
    return laoding == true
        ? Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.white,
                ),
              ),
            ),
          )
        : Container(
            height: 55,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: onPressed,
              child: Custemheadlinemedium(content: content, color: color2),
            ),
          );
  }
}
