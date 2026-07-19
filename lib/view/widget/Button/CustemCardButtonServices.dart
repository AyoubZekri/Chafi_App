import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardbuttonservices extends StatelessWidget {
  final String title;
  final String image;
  final double? width;
  final Color color;
  final Color? color2;

  final double? height;

  final void Function()? onTap;

  const Custemcardbuttonservices({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
    this.width,
    this.height,
    required this.color,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.typography,
              ),
              child: Image.asset(
                image,
                height: 22,
                width: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: AutoSizeText(
                title,
                minFontSize: 7,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColor.typography,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
