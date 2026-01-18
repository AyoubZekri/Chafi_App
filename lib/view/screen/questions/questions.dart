import 'package:flutter/material.dart';

import '../../widget/Card/CustemCardinfo.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الأسئلة الشائعة")),
      body: Container(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) {
            return Custemcardinfo(
              title: "1_كيف تُحتسب الجباية السنوية للمؤسسات:",
              body:
                  "تُعدّ الجباية السنوية من أهم الالتزامات التي يجب على كل مؤسسة احترامها، سواء كانت صغيرة، متوسطة، أو كبيرة. فهم طريقة حساب الجباية يجنّب المؤسسات الأخطاء والغرامات ويُساعدها على التخطيط المالي بشكل أفضل. في هذا المقال، نقدّم شرحًا مبسّطًا وواضحًا لكيفية احتساب الجباية السنوية وفق أهم المبادئ العامة.",
              Calculator: false,
              Link: false,
              onCalculator: () {},
              onLink: () {},
            );
          },
        ),
      ),
    );
  }
}
