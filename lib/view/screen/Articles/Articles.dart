import 'dart:io';

import 'package:chafi/controller/Articles/Articlescontroller.dart';
import 'package:chafi/core/class/handlingview.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../LinkApi.dart';
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
          return Handlingview(
            statusrequest: controller.statusrequest,
            widget: Container(
              child: ListView.builder(
                itemCount: controller.datapost.length,
                itemBuilder: (context, index) {
                  final item = controller.datapost[index];
                  return Custemcardarticles(
                    imgae:  File(item.image!),
                    body: item.localizedTitle,
                    isStatus: item.isExclusive(),
                    onTap: () {
                      controller.gotoditailsarticles(item.id);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
