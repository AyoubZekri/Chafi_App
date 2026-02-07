import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardarticles extends StatefulWidget {
  final String body;
  final String imgae;

  final bool isStatus;

  final void Function()? onTap;

  const Custemcardarticles({
    super.key,
    required this.body,
    this.onTap,
    required this.isStatus,
    required this.imgae,
  });

  @override
  State<Custemcardarticles> createState() => _CustemcardarticlesState();
}

class _CustemcardarticlesState extends State<Custemcardarticles> {
  @override
  Widget build(BuildContext context) {
    final isfr = Get.locale?.languageCode == 'fr';

    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  isfr ? Color(0xff2A82D9) : Color(0xff164573),
                  isfr ? Color(0xff164573) : Color(0xff2A82D9),
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.4, color: AppColor.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: Image.network(
                        widget.imgae,
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                      ),
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
                            widget.body,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              color: AppColor.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isStatus)
            Positioned(
              top: 10,
              left: isfr ? null : 15,
              right: isfr ? 15 : null,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: isfr
                        ? const Radius.circular(0)
                        : const Radius.circular(15),
                    topRight: isfr
                        ? const Radius.circular(15)
                        : const Radius.circular(0),
                    bottomRight: isfr
                        ? const Radius.circular(0)
                        : const Radius.circular(8),
                    bottomLeft: isfr
                        ? const Radius.circular(8)
                        : const Radius.circular(0),
                  ),
                ),
                child: Text(
                  "حصري".tr,
                  style: const TextStyle(color: AppColor.brand, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
