import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/Setting/CustemTitleorBody copy.dart';

class Informationapp extends StatefulWidget {
  const Informationapp({super.key});

  @override
  State<Informationapp> createState() => _InformationappState();
}

class _InformationappState extends State<Informationapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('informationApp'.tr)),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Custemtitleorbody(Body: "informationBody1".tr),

            Custemtitleorbody(Body: "informationBody2".tr),
          ],
        ),
      ),
    );
  }
}
