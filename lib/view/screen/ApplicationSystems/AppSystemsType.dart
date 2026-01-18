import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Appsystemstype extends StatelessWidget {
  const Appsystemstype({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("29".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "53".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: taxsystemstypeapp.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: taxsystemstypeapp[i].ontap,
                  body: taxsystemstypeapp[i].body,
                  imgae: taxsystemstypeapp[i].imgae,
                  color1: Color(0xff4F46E5),
                  color2: Color(0xff8B5CF6),
                  sizeText: taxsystemstypeapp[i].sizeText,
                );
              },
            ),
            SizedBox(height: 40),

            Text(
              "54".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
