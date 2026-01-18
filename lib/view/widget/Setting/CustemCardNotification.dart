import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardnotification extends StatelessWidget {
  final String title;
  final String body;
  final Color color;
  final Color color2;
  final IconData icon;
  final void Function()? ontap;
  final void Function()? ontap2;
  final bool dot;

  const Custemcardnotification({
    super.key,
    required this.title,
    required this.body,
    required this.color,
    required this.color2,
    required this.icon,
    this.ontap,
    this.ontap2,
    required this.dot,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: color, offset: Offset(0, 2)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(
                          width: Get.width - 170,
                          child: Text(
                            body,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: ontap2,
                  child: Icon(icon, color: Colors.grey, size: 30),
                ),
              ],
            ),
          ),
          dot == true
              ? Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColor.red,
                      borderRadius: BorderRadius.circular(180),
                    ),
                  ),
                )
              : Positioned(child: SizedBox()),
        ],
      ),
    );
  }
}
