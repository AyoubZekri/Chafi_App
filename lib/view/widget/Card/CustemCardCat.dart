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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //     color: color2.withOpacity(0.35),
        //     blurRadius: 15,
        //     offset: const Offset(0, 6),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.1),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColor.typography, AppColor.typography],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative circle top right
                  Positioned(
                    top: -30,
                    right: -30,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),
                  // Decorative circle bottom left
                  Positioned(
                    bottom: -40,
                    left: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  // Main Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            body,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: sizeText,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 2,
                            minFontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            textAlign:
                                TextAlign.right, // Assuming Arabic layout
                          ),
                        ),
                        // const SizedBox(width: 15),
                        // Container(
                        //   padding: const EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.2),
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: const Icon(
                        //     Icons.arrow_back_ios_new_rounded, // Left arrow for Arabic RTL
                        //     color: Colors.white,
                        //     size: 16,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
