import 'package:chafi/controller/Articles/Articlescontroller.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:chafi/core/constant/imageassets.DART';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../widget/Articles/CustemCardArticles.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    Get.put(ArticlescontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("40".tr)),
      body: GetBuilder<ArticlescontrollerImp>(
        builder: (controller) {
          return Container(
            child: ListView(
              children: [
                Custemcardarticles(
                  imgae: Appimageassets.one,
                  body: 'كيف تُحتسب الجباية السنوية للمؤسسات؟',
                  isStatus: true,
                  onTap: () {
                    controller.gotoditailsarticles();
                  },
                ),
                Custemcardarticles(
                  imgae: Appimageassets.one,
                  body: 'كيف تُحتسب الجباية السنوية للمؤسسات؟',
                  isStatus: true,
                ),
                Custemcardarticles(
                  imgae: Appimageassets.one,
                  body: 'كيف تُحتسب الجباية السنوية للمؤسسات؟',
                  isStatus: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
