import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessCard extends StatelessWidget {
  final String active;
  final int condition;
  final void Function()? ontap;
  final void Function()? onTap;

  const BusinessCard({
    super.key,
    required this.active,
    required this.condition,
    this.ontap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColor.primarycolor.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                // 1. Light background glow blobs
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.brand.withOpacity(0.04),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  left: -40,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primarycolor.withOpacity(0.04),
                    ),
                  ),
                ),
                // 2. Custom Background Waves
                Positioned.fill(
                  child: CustomPaint(painter: _BusinessCardBgPainter()),
                ),
                // 3. Main Content
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row: Seal + Title
                      Row(
                        children: [
                          // Gold Emblem / Digital Seal
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.brand.withOpacity(0.1),
                              border: Border.all(
                                color: AppColor.brand,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.brand.withOpacity(0.2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.gavel_rounded,
                              color: AppColor.brand,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "البيان الجبائي".tr,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: AppColor.typography,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "77".tr,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.typography.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Arrow indicator
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.typography,
                              size: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Elegant gold laser line divider
                      Container(
                        height: 1.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.typography.withOpacity(0.1),
                              AppColor.typography.withOpacity(0.4),
                              AppColor.typography.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Primary Activity - Glass/Light Blue Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.typography.withOpacity(0.04),
                              AppColor.typography.withOpacity(0.01),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColor.typography.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColor.brand.withOpacity(0.12),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.brand.withOpacity(0.2),
                                ),
                              ),
                              child: const Icon(
                                Icons.storefront_rounded,
                                color: AppColor.brand,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "67".tr,
                                    style: const TextStyle(
                                      color: AppColor.brand,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    active,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColor.typography,
                                      fontWeight: FontWeight.w800,
                                      height: 1.5,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BusinessCardBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Soft blue curve
    final paint1 = Paint()
      ..color = const Color(0xFF034D82).withOpacity(0.025)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.85);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.45,
      size.width * 0.65,
      size.height * 0.8,
    );
    path1.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.95,
      size.width,
      size.height * 0.7,
    );
    canvas.drawPath(path1, paint1);

    // Soft amber curve
    final paint2 = Paint()
      ..color = AppColor.brand.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.5);
    path2.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.75,
      size.width * 0.7,
      size.height * 0.35,
    );
    path2.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.2,
      size.width,
      size.height * 0.45,
    );
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
