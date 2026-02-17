import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Calculators extends StatelessWidget {
  const Calculators({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("الحاسبة".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "إختر النظام الذي يهمك لتحديد الحاسبات الخاصة بك".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: calculators.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: calculators[i].ontap,
                  body: calculators[i].body,
                  imgae: calculators[i].imgae,
                  color1: Color(0xff34C759),
                  color2: Color(0xff19612B),
                  sizeText: calculators[i].sizeText,
                );
              },
            ),
            SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
