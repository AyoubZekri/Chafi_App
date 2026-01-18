import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Institutiontype extends StatefulWidget {
  const Institutiontype({super.key});

  @override
  State<Institutiontype> createState() => _InstitutiontypeState();
}

class _InstitutiontypeState extends State<Institutiontype> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("44".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "45".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: institutionType.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: institutionType[i].ontap,
                  body: institutionType[i].body,
                  imgae: institutionType[i].imgae,
                  color1: institutionType[i].color1,
                  color2: institutionType[i].color2,
                  sizeText: institutionType[i].sizeText,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
