import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custemcontactus extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final Color color;
  final double sizeImg;
  final double padding;


  final void Function()? ontap;

  const Custemcontactus({
    super.key,
    required this.image,
    required this.title,
    required this.body,
    required this.color,
    this.ontap,
    required this.sizeImg, required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,

      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: color,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: sizeImg,
                      height: sizeImg,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: Colors.black),
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
          ],
        ),
      ),
    );
  }
}
