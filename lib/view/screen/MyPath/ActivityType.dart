import 'package:flutter/material.dart';
import 'package:chafi/core/constant/Colorapp.dart';
import 'package:get/get.dart';

import '../../../controller/Recorde/MypathController.dart';
import '../../../core/class/handlingview.dart';
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
                          LawSearchBar(
                            onChanged: (value) {
                              controller.search(value);
                            },
                          ),

                          const SizedBox(height: 30),
                          CustemtextbodyMedium18(
                            content: "61".tr,
                            color: AppColor.black,
                          ),
                          SizedBox(height: 70),
                          controller.filteredData.isEmpty
                              ? SizedBox(
                                  height: 250,
                                  child: Handlingview(
                                    statusrequest: controller.statusrequest,
                                    widget: SizedBox(),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.filteredData.length,
                                  itemBuilder: (context, i) {
                                    return Cardacteve(
                                      description: controller
                                          .filteredData[i]
                                          .localizedBody,
                                      padding: 20,
                                      marginb: 30,
                                      index: controller.filteredData[i].id,
                                      title: controller
                                          .filteredData[i]
                                          .localizedName,
                                      selectedPerson: controller.ativitytype,
                                      onTap: () {
                                        controller.selectativitytype(
                                          controller.filteredData[i].id,
                                           controller.filteredData[i].statusTax,
                                           controller.filteredData[i].taxId,
                                        );
                                      },
                                    );
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
