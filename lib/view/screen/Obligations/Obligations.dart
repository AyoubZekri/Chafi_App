import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/datasource/statec/statec.dart';
import '../../widget/Card/CustemCardRow.dart';

class Obligations extends StatelessWidget {
  const Obligations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("المواعيد والإلتزمات".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "إختر النظام الذي يهمك لتحديد المواعيد الخاصة بك".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              itemCount: obligationstype.length,
              itemBuilder: (context, i) {
                return Custemcardrow(
                  onTap: obligationstype[i].ontap,
                  body: obligationstype[i].body,
                  imgae: obligationstype[i].imgae,
                  color1: const Color(0xFFF59E0B),
                  color2: const Color(0xFFB45309),
                  sizeText: obligationstype[i].sizeText,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
