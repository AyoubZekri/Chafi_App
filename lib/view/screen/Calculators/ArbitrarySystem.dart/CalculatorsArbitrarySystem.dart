import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/Colorapp.dart';
import '../../../../data/datasource/statec/statec.dart';
import '../../../widget/Card/CustemCardRow.dart';

class Calculatorsarbitrarysystem extends StatelessWidget {
  const Calculatorsarbitrarysystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("الحاسبة".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: calculatorsofSystemarbitrary.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: calculatorsofSystemarbitrary[i].ontap,
                  body: calculatorsofSystemarbitrary[i].body,
                  imgae: calculatorsofSystemarbitrary[i].imgae,
                  color1: Color(0xff34C759),
                  color2: Color(0xff19612B),
                  sizeText: calculatorsofSystemarbitrary[i].sizeText,
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
