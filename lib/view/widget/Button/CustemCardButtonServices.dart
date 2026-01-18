import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        height: height ?? (Get.width / 3) - 17,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: width ?? (Get.width / 3) - 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color2 == null ? color : null,
          gradient: color2 != null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color, ?color2],
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180),
              ),
              child: Image.asset(image, height: 35, width: 35),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
