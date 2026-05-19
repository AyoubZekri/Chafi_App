import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardcat extends StatelessWidget {
  final String body;
  final Color color1;
  final Color color2;
  final double sizeText;

  final void Function()? onTap;

  const Custemcardcat({
    super.key,
    required this.body,
    this.onTap,
    required this.color1,
    required this.color2,
    required this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [color1, color2],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SizedBox(
            width: 230,
            child: AutoSizeText(
              body,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: sizeText,
                color: AppColor.white,
              ),
              maxLines: 2,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
