import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/Colorapp.dart';

class Custemcardinfo extends StatefulWidget {
  final String body;
  final String title;
  final VoidCallback? onCalculator;
  final VoidCallback? onLink;
  final bool Calculator;
  final bool Link;
  final VoidCallback? onOpen;
  final bool? isRead;

  const Custemcardinfo({
    super.key,
    required this.body,
    required this.title,
    this.onCalculator,
    this.onLink,
    required this.Calculator,
    required this.Link,
    this.onOpen,
    this.isRead,
  });

  @override
  State<Custemcardinfo> createState() => _CustemcardinfoState();
}

class _CustemcardinfoState extends State<Custemcardinfo>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;

          if (isOpen && widget.onOpen != null) {
            widget.onOpen!();
          }
        });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== TITLE =====
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: AppColor.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),

                /// ===== BODY + ACTIONS =====
                AnimatedSize(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: isOpen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              widget.body,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            if (widget.Calculator || widget.Link) ...[
                              const SizedBox(height: 15),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  if (widget.Calculator)
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: widget.onCalculator,
                                        icon: const Icon(Icons.calculate),
                                        label: const Text("حاسبة"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColor.typography,
                                          side: const BorderSide(
                                            color: AppColor.typography,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (widget.Link) const SizedBox(width: 10),
                                  if (widget.Link)
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: widget.onLink,
                                        icon: const Icon(Icons.link),
                                        label: const Text("رابط"),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColor.typography,
                                          side: const BorderSide(
                                            color: AppColor.typography,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),

          /// ===== مؤشر القراءة =====
          if (widget.isRead == true)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColor.acteve,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
