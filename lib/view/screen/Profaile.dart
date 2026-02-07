import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/ProfaileController.dart';
import '../../core/functions/Dealog.dart';
import '../widget/Setting/buildDeadlineTile.dart';

class Profaile extends StatefulWidget {
  const Profaile({super.key});

  @override
  State<Profaile> createState() => _ProfaileState();
}

class _ProfaileState extends State<Profaile> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfailecontrollerImp());

    return Scaffold(
      appBar: AppBar(title: Text("79".tr)),
      body: GetBuilder<ProfailecontrollerImp>(
        builder: (controller) {
          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.typography,
                              child: Text(
                                "AZ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Ayoub Zekri",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1F39),
                        ),
                      ),
                      Text(
                        "ayoubzekri@gmail.com",
                        style: TextStyle(color: Colors.grey),
                      ),

                      SizedBox(height: 30),
                      _buildSectionTitle("80".tr),
                      _buildSettingsCard([
                        Builddeadlinetile(
                          icon: Icons.person_outline,
                          title: "79".tr,
                          ontap: () {
                            controller.gotoEditProfaile();
                          },
                        ),
                        Builddeadlinetile(
                          icon: Icons.notifications_outlined,
                          title: "83".tr,
                          ontap: () {
                            controller.gotoNotification();
                          },
                        ),
                        Builddeadlinetile(
                          icon: Icons.language_outlined,
                          title: "84".tr,
                          ontap: () {
                            controller.showLanguageSheet(context);
                          },
                        ),
                        Builddeadlinetile(
                          icon: Icons.logout,
                          title: "85".tr,
                          ontap: () async {
                            await showCustomConfirmationDialog(
                              context,

                              message: "هل تريد تسجيل الخروج?".tr,
                              onConfirmAction: () {
                                controller.logout();
                              },
                            );
                          },
                        ),
                      ]),

                      SizedBox(height: 20),
                      _buildSettingsCard([
                        Builddeadlinetile(
                          icon: Icons.link,
                          title: "روابط خارجية".tr,
                          ontap: () {
                            controller.gotoExternallinks();
                          },
                        ),
                      ]),
                      SizedBox(height: 20),

                      _buildSectionTitle("81".tr),
                      _buildSettingsCard([
                        Builddeadlinetile(
                          icon: Icons.headset_mic_outlined,
                          title: "86".tr,
                          ontap: () {
                            controller.gotoContactus();
                          },
                        ),
                        Builddeadlinetile(
                          icon: Icons.privacy_tip_outlined,
                          title: "87".tr,
                          ontap: () {
                            controller.gotoPrivacypolicy();
                          },
                        ),
                        Builddeadlinetile(
                          icon: Icons.info_outline,
                          title: "88".tr,
                          ontap: () {
                            controller.gotoInformationapp();
                          },
                        ),
                      ]),

                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F1F39),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}
