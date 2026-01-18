import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  final String image;
  final String image2;
  final void Function()? ontap;

  const Welcome({
    super.key,
    required this.image,
    required this.image2,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue[100],
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "20".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2833),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "21".tr,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: Color(0xFF566573),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: ontap,
          child: Image.asset(
            image2,
            width: 58,
            height: 47,
            color: Color(0xFF154360),
          ),
        ),
      ],
    );
  }
}
