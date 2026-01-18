import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Taxsystemstype extends StatelessWidget {
  const Taxsystemstype({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("26".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "51".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: taxsystemstype.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: taxsystemstype[i].ontap,
                  body: taxsystemstype[i].body,
                  imgae: taxsystemstype[i].imgae,
                  color2: Color(0xFF7333BD),
                  color1: Color(0xff270C46),
                  sizeText: taxsystemstype[i].sizeText,
                );
              },
            ),
            SizedBox(height: 40),

            Text(
              "52".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
