import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controller/Institutions/InstitutioninfoController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Card/CustemCardinfo.dart';

class Institutionsinfo extends StatefulWidget {
  const Institutionsinfo({super.key});

  @override
  State<Institutionsinfo> createState() => _InstitutionsinfoState();
}

class _InstitutionsinfoState extends State<Institutionsinfo> {
  @override
  Widget build(BuildContext context) {
    Get.put(InstitutioninfocontrollerImp());
    return GetBuilder<InstitutioninfocontrollerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: AppBar(title: Text("${controller.nameappar}".tr)),
          body: Container(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, i) {
                return Custemcardinfo(
                  title: "1_كيف تُحتسب الجباية السنوية للمؤسسات:",
                  body:
                      "تُعدّ الجباية السنوية من أهم الالتزامات التي يجب على كل مؤسسة احترامها، سواء كانت صغيرة، متوسطة، أو كبيرة. فهم طريقة حساب الجباية يجنّب المؤسسات الأخطاء والغرامات ويُساعدها على التخطيط المالي بشكل أفضل. في هذا المقال، نقدّم شرحًا مبسّطًا وواضحًا لكيفية احتساب الجباية السنوية وفق أهم المبادئ العامة.",
                  Calculator: i % 2 == 0 ? true : false,
                  Link: i % 2 == 0 ? true : false,
                  onCalculator: () {},
                  onLink: () {},
                );
              },
            ),
          ),
        );
      },
    );
  }
}
