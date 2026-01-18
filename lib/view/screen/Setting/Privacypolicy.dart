import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/Setting/CustemTitleorBody copy.dart';

class Privacypolicy extends StatefulWidget {
  const Privacypolicy({super.key});

  @override
  State<Privacypolicy> createState() => _PrivacypolicyState();
}

class _PrivacypolicyState extends State<Privacypolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Privacy Policy'.tr,
        ),
      ),
      body: Container(
        margin:const EdgeInsets.all(20),
        child: ListView(
          children:  [
            Custemtitleorbody(
              title: "94".tr,
              Body:"95".tr,
            ),
            Custemtitleorbody(
              title: "المعلومات التي نجمعها".tr,
              Body: "96".tr
            ),
            Custemtitleorbody(
              title: "97".tr,
              Body: "98".tr,
            ),
            Custemtitleorbody(
              title: "99".tr,
              Body: "100".tr
            ),
            Custemtitleorbody(
              title: "101".tr,
              Body: "102".tr
            ),

          ],
        ),
      ),
    );
  }
}
