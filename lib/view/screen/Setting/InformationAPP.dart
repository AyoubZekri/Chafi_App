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
            Custemtitleorbody(
              Body:
                  "تطبيق شافي (CHAFI) هو منصة رقمية مبتكرة تهدف إلى تبسيط العملية الجبائية وتسهيل التواصل بين الإدارة الضريبية والمكلفين بالضريبة. يقدّم التطبيق أدوات متكاملة لمساعدة المؤسسات الناشئة والصغيرة على الامتثال للالتزامات الضريبية بسهولة وسرعة، مع تعزيز الفهم لمفاهيم الجباية لدى الطلبة الأكاديميين والمهتمين بالمحاسبة في المؤسسات العامة والخاصة."
                      .tr,
            ),

            Custemtitleorbody(
              Body:
                  "من خلال شافي، يمكن للمستخدمين متابعة التزاماتهم الضريبية، الحصول على شروحات وتوضيحات مبسطة، والاستفادة من تجربة رقمية سلسة تدعم التعليم العملي والامتثال القانوني في نفس الوقت."
                      .tr,
            ),
          ],
        ),
      ),
    );
  }
}
