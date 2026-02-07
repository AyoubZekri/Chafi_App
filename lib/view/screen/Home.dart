import 'package:chafi/LinkApi.dart';
import 'package:chafi/core/constant/imageassets.DART';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/HomeController.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/home/CustemCardHome.dart';
import '../widget/home/ScrollCardServece.dart';
import '../widget/home/Slaider.dart';
import '../widget/home/Welcome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Get.put(HomecontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<HomecontrollerImp>(
        builder: (controller) {
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Welcome(
                      image2: Appimageassets.notification,
                      image: Appimageassets.avater,
                      ontap: () {},
                    ),
                    SizedBox(height: 20),
                    Slaider(),
                    SizedBox(height: 40),
                    Text(
                      "22".tr,
                      style: context.textTheme.headlineLarge,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Scrollcardservece(),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "23".tr,
                          style: context.textTheme.headlineLarge,
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          onTap: () {
                            controller.gotoArticles();
                          },
                          child: Text(
                            "24".tr,
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: AppColor.primarycolor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20, right: 20),
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.datapost.length,
                  itemBuilder: (context, index) {
                    final item = controller.datapost[index];
                    return Custemcardhome(
                      image: "${Applink.image}${item.image}",
                      content: item.localizedTitle,
                      onTap: () {
                        controller.gotoditailsarticles(item.id);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
