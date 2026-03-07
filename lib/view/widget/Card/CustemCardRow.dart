import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardrow extends StatelessWidget {
  final String body;
  final String imgae;
  final Color color1;
  final Color color2;
  final double sizeText;

  final void Function()? onTap;

  const Custemcardrow({
    super.key,
    required this.body,
    this.onTap,
    required this.imgae,
    required this.color1,
    required this.color2,
    required this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: Get.locale?.languageCode == "ar"
                ? [color1, color2]
                : [color2, color1],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.asset(imgae, height: 70, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230,
                    child: Text(
                      body,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: sizeText,
                        color: AppColor.white,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomCalculatorCard extends StatelessWidget {
//   final String title;
//   final String image;
//   final Color color1;
//   final Color color2;
//   final double sizeText;
//   final VoidCallback? onTap;

//   const CustomCalculatorCard({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.color1,
//     required this.color2,
//     required this.sizeText,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(22),
//           child: Stack(
//             children: [
//               // Gradient Background
//               Container(
//                 height: 120,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [color1, color2],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//               ),

//               // Glass Overlay خفيف
//               // Positioned.fill(
//               //   child: BackdropFilter(
//               //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//               //     child: Container(color: Colors.white.withOpacity(0.05)),
//               //   ),
//               // ),

//               // Content
//               Container(
//                 height: 120,
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     // Image Circle
//                     Container(
//                       height: 70,
//                       width: 70,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.15),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Image.asset(image, fit: BoxFit.contain),
//                       ),
//                     ),

//                     const SizedBox(width: 20),

//                     // Title
//                     Expanded(
//                       child: Text(
//                         title,
//                         style: context.textTheme.titleMedium?.copyWith(
//                           fontSize: sizeText,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),

//                     // Arrow
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white.withOpacity(0.2),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomCalculatorCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;
  final Color color1;
  final Color color2;
  final double sizeText;

  const CustomCalculatorCard({
    super.key,
    required this.title,
    required this.image,
    this.onTap,
    required this.color1,
    required this.color2,
    required this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Get.locale?.languageCode == "ar"
                ? [color1, color2]
                : [color2, color1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              // Glass overlay
              // Positioned.fill(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              //     child: Container(color: Colors.white.withOpacity(0.05)),
              //   ),
              // ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Circle image
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 20),
                    // Title + subtitle
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            title,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: sizeText,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            minFontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Arrow icon
                    SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
