import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Institutionfield extends StatefulWidget {
  const Institutionfield({super.key});

  @override
  State<Institutionfield> createState() => _InstitutionfieldState();
}

class _InstitutionfieldState extends State<Institutionfield> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("41".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "42".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 50),
            ListView.builder(
              shrinkWrap: true,
              itemCount: institutionfild.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: institutionfild[i].ontap,
                  body: institutionfild[i].body,
                  imgae: institutionfild[i].imgae,
                  color1: institutionfild[i].color1,
                  color2: institutionfild[i].color2,
                  sizeText: institutionfild[i].sizeText,
                );
              },
            ),

            SizedBox(height: 40),

            Text(
              "43".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
