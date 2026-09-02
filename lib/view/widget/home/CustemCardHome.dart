import 'dart:io';

import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../LinkApi.dart';

class Custemcardhome extends StatelessWidget {
  final String image;
  final String content;
  final Function()? onTap;

  const Custemcardhome({
    super.key,
    required this.image,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20),
        width: 255,
        decoration: BoxDecoration(
          color: Color(0xffEFF5F4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: image.startsWith('Post/')
                  ? Image.network(
                      '${Applink.image}$image',
                      width: 238,
                      height: 159,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 40),
                    )
                  : Image.file(
                      File(image),
                      width: 238,
                      height: 159,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 40),
                    ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 230,
              child: Text(
                content,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 18,
                  color: AppColor.black,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
