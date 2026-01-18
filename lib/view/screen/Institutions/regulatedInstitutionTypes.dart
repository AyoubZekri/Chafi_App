import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Regulatedinstitutiontypes extends StatelessWidget {
  const Regulatedinstitutiontypes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("46".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "47".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: regulatedInstitutionTypes.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: regulatedInstitutionTypes[i].ontap,
                  body: regulatedInstitutionTypes[i].body,
                  imgae: regulatedInstitutionTypes[i].imgae,
                  color1: Color(0xff3C581F),
                  color2: Color(0xff82BE42),
                  sizeText: regulatedInstitutionTypes[i].sizeText,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
