import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';
import '../../widget/Records/CustemBusinessCardditails.dart';

class Inforecord extends StatefulWidget {
  const Inforecord({super.key});

  @override
  State<Inforecord> createState() => _InforecordState();
}

class _InforecordState extends State<Inforecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("تفاصيل السجل")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Custembusinesscardditails(
              acteve: 'تاجر',
              condition: 1,
              persontype: 'شخص طبيعي',
              name: 'أيوب زكري',
              address: 'الوادي',
              numperTax: '004569872345789',
              codeActeve: '4690',
            ),
          ],
        ),
      ),
    );
  }
}
