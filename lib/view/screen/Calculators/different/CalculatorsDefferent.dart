import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/Colorapp.dart';
import '../../../../data/datasource/statec/statec.dart';
import '../../../widget/Card/CustemCardRow.dart';

class Calculatorsdefferent extends StatelessWidget {
  const Calculatorsdefferent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("الحاسبة".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: calculatorsofDiffernt.length,
          itemBuilder: (context, i) {
            return CustomCalculatorCard(
              onTap: calculatorsofDiffernt[i].ontap,
              title: calculatorsofDiffernt[i].body.tr,
              image: calculatorsofDiffernt[i].imgae,
              color1: Color(0xff34C759),
              color2: Color(0xff19612B),
              sizeText: calculatorsofDiffernt[i].sizeText,
            );
          },
        ),
      ),
    );
  }
}
