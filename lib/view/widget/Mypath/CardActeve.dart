import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Cardacteve extends StatefulWidget {
  final int index;
  final String description;
  final double padding;
  final double marginb;
  final int selectedPerson;
  final VoidCallback onTap;

  const Cardacteve({
    super.key,
    required this.index,
    required this.description,
    required this.selectedPerson,
    required this.onTap,
    required this.padding,
    this.marginb = 50,
  });

  @override
  State<Cardacteve> createState() => _CardacteveState();
}

class _CardacteveState extends State<Cardacteve> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.selectedPerson == widget.index;

    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: widget.padding, horizontal: 30),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: widget.marginb),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Content Header =====
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.description,
                    maxLines: isExpanded ? null : 1,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColor.typography,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    width: 26,
                    height: 26,
                    margin: const EdgeInsets.only(top: 4),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
