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
            return RefreshIndicator(
              color: AppColor.typography,
              onRefresh: () async {
                await controller.getData();
              },
              child: Container(
                color: AppColor.typography,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      // ===== Fixed Top Section =====
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            CustemtextbodyMedium18(
                              color: AppColor.grey,
                              content: "61".tr,
                            ),
                            const SizedBox(height: 15),
                            LawSearchBar(
                              controller: controller.searchController,
                              onChanged: (value) {
                                controller.search(value);
                              },
                            ),
                            // const SizedBox(height: 30),
                            // CustemtextbodyMedium18(
                            //   content: "61".tr,
                            //   color: AppColor.black,
                            // ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),

                      // ===== Scrollable List Section =====
                      Expanded(
                        child: controller.filteredData.isEmpty
                            ? Center(
                                child: Handlingview(
                                  statusrequest: controller.statusrequest,
                                  widget: const SizedBox(),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.fromLTRB(
                                  25,
                                  10,
                                  25,
                                  180,
                                ), // Added bottom padding for buttons
                                itemCount: controller.filteredData.length,
                                itemBuilder: (context, i) {
                                  return Cardacteve(
                                    description: controller
                                        .filteredData[i]
                                        .localizedBody,
                                    padding: 20,
                                    marginb: 30,
                                    index: controller.filteredData[i].id,
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        bottomSheet: Padding(
          padding: const EdgeInsets.all(25),
          child: Custemsuberbutton(
            content: "60".tr,
            color: AppColor.typography,
            onPressed: () {
              Get.find<MypathcontrollerImp>().gotoTaxsystemstype();
            },
          ),
        ),
      ),
    );
  }
}
