import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chafi/core/constant/Colorapp.dart';

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
    required this.onTap, required this.padding,  this.marginb= 50,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedPerson == index;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical:padding,horizontal: 30),
        width: double.infinity,
        margin:  EdgeInsets.only(bottom: marginb),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.headlineLarge?.copyWith(
                color: AppColor.typography,
              ),
            ),

            // دائرة الاختيار
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.typography, width: 2),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.typography,
                        ),
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
