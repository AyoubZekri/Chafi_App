import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custembuttonsignin extends StatelessWidget {
  final String contentText;
  final String contentImage;
  final bool laoding;

  final void Function()? onTap;
  const Custembuttonsignin({
    super.key,
    required this.contentText,
    required this.contentImage,
    this.onTap,
    required this.laoding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 260,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.typography, width: 1),
        ),
        child: laoding == true
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColor.typography,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: Get.locale == Locale("fr") ? 30 : 10),
                  Transform.translate(
                    offset: const Offset(0, -4),
                    child: Text(
                      contentText,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontFamily: "Cairo",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Image.asset(contentImage, height: 50),
                ],
              ),
      ),
    );
  }
}
