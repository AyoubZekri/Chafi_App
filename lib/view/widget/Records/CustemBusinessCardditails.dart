import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Custembusinesscardditails extends StatelessWidget {
  final String acteve;
  final int condition;
  final String persontype;
  final String name;
  final String address;
  final int numperTax;
  final String codeActeve;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const Custembusinesscardditails({
    super.key,
    required this.acteve,
    required this.condition,
    required this.persontype,
    required this.name,
    required this.address,
    required this.numperTax,
    required this.codeActeve,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // 1. Light, elegant background glow blobs (very subtle daylight colors)
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
              // 2. High-end Custom Background Waves
              Positioned.fill(
                child: CustomPaint(painter: CardBackgroundPainter()),
              ),
              // 3. Main Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row: Logo/Seal, Title and Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Right side: Official Title & Badge
                        Row(
                          children: [
                            // Gold Emblem / Digital Seal
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber.shade100.withOpacity(0.4),
                                border: Border.all(
                                  color: Colors.amber.shade600,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.shade300.withOpacity(
                                      0.1,
                                    ),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.gavel_rounded,
                                color: Colors.amber.shade700,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
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
                                  "بطاقة الهوية الجبائية".tr,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.typography.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Left side: Sleek action icons inside card
                        if (onEdit != null || onDelete != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (onEdit != null && numperTax != 3)
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit_rounded,
                                      color: AppColor.typography,
                                      size: 16,
                                    ),
                                    onPressed: onEdit,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(8),
                                    splashRadius: 18,
                                  ),
                                ),
                              if (onEdit != null &&
                                  onDelete != null &&
                                  numperTax != 3)
                                const SizedBox(width: 8),
                              if (onDelete != null)
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF2F2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFFEE2E2),
                                      width: 1,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      color: Color(0xFFEF4444),
                                      size: 16,
                                    ),
                                    onPressed: onDelete,
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(8),
                                    splashRadius: 18,
                                  ),
                                ),
                            ],
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
                            Colors.amber.shade400.withOpacity(0.1),
                            Colors.amber.shade400.withOpacity(0.6),
                            Colors.amber.shade400.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Primary Activity (النشاط الرئيسي) - High-end Glass/Light Blue Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEBF5FF), Color(0xFFF4F9FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD0E5FF),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.primarycolor.withOpacity(0.12),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.primarycolor.withOpacity(0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.storefront_rounded,
                              color: AppColor.primarycolor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "67".tr, // "النشاط"
                                  style: const TextStyle(
                                    color: Color(0xFFC5A059),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  acteve,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColor.typography,
                                    fontWeight: FontWeight.w800,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Grid-like layout for remaining details
                    _buildGlassDetailsGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassDetailsGrid() {
    return Column(
      children: [
        _buildDetailTile(
          label: "71".tr, // "الشكل القانوني"
          value: persontype,
          icon: Icons.business_rounded,
        ),
        if (codeActeve != "null".tr) ...[
          const SizedBox(height: 14),
          _buildDetailTile(
            label: "75".tr, // "رمز النشاط"
            value: codeActeve,
            icon: Icons.tag_rounded,
          ),
        ],

        const SizedBox(height: 14),
        _buildDetailTile(
          label: "الممثل القانوني".tr,
          value: name,
          icon: Icons.person_pin_rounded,
        ),
        const SizedBox(height: 14),
        _buildDetailTile(
          label: "74".tr, // "النظام الجبائي"
          value: numperTax == 0 || numperTax == 3
              ? "49".tr
              : numperTax == 1
              ? "50".tr
              : "48".tr,
          icon: Icons.receipt_long_rounded,
          valueColor: const Color(0xFFC5A059),
        ),
        const SizedBox(height: 14),
        _buildDetailTile(
          label: "73".tr, // "العنوان"
          value: address,
          icon: Icons.location_on_rounded,
        ),
      ],
    );
  }

  Widget _buildDetailTile({
    required String label,
    required String value,
    required IconData icon,
    bool isFullWidth = false,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Premium Icon Badge
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.primarycolor.withOpacity(0.08),
              border: Border.all(
                color: AppColor.primarycolor.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Icon(icon, color: AppColor.primarycolor, size: 20),
          ),
          const SizedBox(width: 14),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(
                      0xFF475569,
                    ), // Slate 600 - high contrast readable gray-blue
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: valueColor ?? AppColor.typography,
                    fontWeight: FontWeight.w800,
                    height: 1.4, // Prevents text overlaps when wrapping
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardBackgroundPainter extends CustomPainter {
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
      ..color = Colors.amber.withOpacity(0.02)
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
