import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custembuttonsignin extends StatelessWidget {
  final String contentText;
  final String contentImage;
  final void Function()? onTap;
  const Custembuttonsignin({
    super.key,
    required this.contentText,
    required this.contentImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: Get.locale == Locale("fr") ? 30 : 10),
          Transform.translate(
            offset: const Offset(0, -4),
            child: Text(
              contentText,
              style: context.textTheme.bodyMedium?.copyWith(
                fontFamily: "Cairo",
              ),
            ),
          ),
          SizedBox(width: 10),
          Image.asset(contentImage, height: 50),
        ],
      ),
    );
  }
}
