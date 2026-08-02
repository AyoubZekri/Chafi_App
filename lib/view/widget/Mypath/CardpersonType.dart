import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Cardpersontype extends StatelessWidget {
  final int index;
  final String title;
  final double padding;
  final double marginb;
  final int selectedPerson;
  final VoidCallback onTap;

  const Cardpersontype({
    super.key,
    required this.index,
    required this.title,
    required this.selectedPerson,
    required this.onTap,
    required this.padding,
    this.marginb = 50,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPerson == index;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: padding, horizontal: 30),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: marginb),
        decoration: BoxDecoration(
          color: const Color(0xffE8F1FF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Get.locale?.languageCode == "ar"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: AutoSizeText(
                  title,
                  minFontSize: 16, // أصغر حجم يمكن أن يصل إليه النص
                  maxLines: 2, // البقاء في سطر واحد
                  overflow: TextOverflow
                      .ellipsis, // وضع نقاط إذا تجاوز النص الحجم الأصغر
                  style: context.textTheme.headlineLarge?.copyWith(
                    color: AppColor.typography,
                    height: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.typography, width: 2),
              ),
              child: isSelected
                  ? const Center(
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: AppColor.typography,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
