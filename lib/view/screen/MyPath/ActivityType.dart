import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/Mypath/CardActeve.dart';
import '../../widget/Mypath/CustemSearchActevty.dart';
import '../../widget/Text/CustemtextbodyMedium18.dart';

class Activitytype extends StatefulWidget {
  const Activitytype({super.key});

  @override
  State<Activitytype> createState() => _ActivitytypeState();
}

class _ActivitytypeState extends State<Activitytype> {
  @override
  Widget build(BuildContext context) {
    Get.put(MypathcontrollerImp());
    return WillPopScope(
      onWillPop: () async {
        Get.find<MypathcontrollerImp>().backtonatureofactivity();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          title: Text("55".tr),
          titleTextStyle: TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Almiri",
            fontSize: 24,
          ),
          iconTheme: IconThemeData(color: AppColor.white),
          backgroundColor: AppColor.typography,
          elevation: 0,
        ),
        body: GetBuilder<MypathcontrollerImp>(
          builder: (controller) {
            return Container(
              color: AppColor.typography,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          CustemtextbodyMedium18(
                            color: AppColor.grey,
                            content: "56".tr,
                          ),
                          SizedBox(height: 40),
                          LawSearchBar(),

                          const SizedBox(height: 30),
                          CustemtextbodyMedium18(
                            content: "61".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),
                          Cardacteve(
                            description:
                                "نشاط يخص شراء السلع بكميات كبيرة من المنتجين أو المستوردين وإعادة بيعها للتجار أو المهنيين. "
                                "هذا النوع من النشاط يتميز بحجم معاملات مرتفع وهوامش ربح أقل، ويتطلب تنظيمًا دقيقًا "
                                "للفواتير والتصريحات الجبائية.",
                            padding: 20,
                            marginb: 30,
                            index: 0,
                            title: "بيع بالجملة".tr,
                            selectedPerson: controller.ativitytype,
                            onTap: () {
                              controller.selectativitytype(0);
                            },
                          ),

                          Cardacteve(
                            description:
                                "نشاط موجه لبيع السلع مباشرة للمستهلك النهائي بكميات صغيرة. "
                                "يُعد من أكثر الأنشطة انتشارًا، ويتميز بتعامل مباشر مع الزبائن "
                                "ويتطلب مسك سجل مبيعات واحترام الالتزامات الجبائية الدورية.",
                            padding: 20,
                            marginb: 30,
                            index: 1,
                            title: "بيع بالتجزئة".tr,
                            selectedPerson: controller.ativitytype,
                            onTap: () {
                              controller.selectativitytype(1);
                            },
                          ),

                          Cardacteve(
                            description:
                                "نشاط تجاري مرتبط بإدخال السلع من الخارج أو إخراجها إلى الأسواق الدولية. "
                                "يخضع لإجراءات جمركية وتنظيمات خاصة، ويتطلب معرفة دقيقة بالتصريحات الجبائية "
                                "والرسوم والضرائب المرتبطة بالتجارة الخارجية.",
                            padding: 20,
                            marginb: 30,
                            index: 2,
                            title: "الاستيراد والتصدير".tr,
                            selectedPerson: controller.ativitytype,
                            onTap: () {
                              controller.selectativitytype(2);
                            },
                          ),

                          Cardacteve(
                            description:
                                "نشاط وسيط يربط بين المنتجين أو المستوردين ونقاط البيع بالتجزئة. "
                                "يرتكز على نقل وتخزين وتوزيع السلع، ويتطلب تنظيمًا محكمًا للمخزون "
                                "والفواتير لتفادي أي إشكالات جبائية.",
                            padding: 20,
                            marginb: 30,
                            index: 3,
                            title: "التوزيع".tr,
                            selectedPerson: controller.ativitytype,
                            onTap: () {
                              controller.selectativitytype(3);
                            },
                          ),

                          Custemsuberbutton(
                            content: "60".tr,
                            color: AppColor.typography,
                            onPressed: () {
                              controller.gotoTaxsystemstype();
                            },
                          ),
                          const SizedBox(height: 20),

                          Custemsuberbutton(
                            content: "62".tr,
                            color: Color(0xffE8F1FF),
                            color2: AppColor.brand,
                            onPressed: () {
                              controller.backtonatureofactivity();
                            },
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
