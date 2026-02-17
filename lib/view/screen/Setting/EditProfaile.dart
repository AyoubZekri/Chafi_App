import 'package:chafi/controller/Setting/EditProfaileController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/TextFild/CustemTextFromFildInfoUser.dart';

class Editprofaile extends StatefulWidget {
  const Editprofaile({super.key});

  @override
  State<Editprofaile> createState() => _EditprofaileState();
}

class _EditprofaileState extends State<Editprofaile> {
  @override
  Widget build(BuildContext context) {
    Get.put(EditprofailecontrollerImp());
    return Scaffold(
      appBar: AppBar(title: Text("تعديل الملف الشخصي".tr)),
      body: GetBuilder<EditprofailecontrollerImp>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                SizedBox(height: 50),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 105),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(180),
                    border: Border.all(width: 2, color: AppColor.primarycolor),
                  ),
                  child: controller.image == null
                      ? MaterialButton(
                          onPressed: () {
                            controller.uploadimagefile();
                          },
                          child: Text("اضافة صورة".tr),
                        )
                      : Stack(
                          children: [
                            ClipOval(
                              child: Image.file(
                                controller.image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(83, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      controller.uploadimagefile();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(height: 50),

                CustemtextfromfildInfoUser(
                  myController: controller.username,
                  hintText: "15".tr,
                  enabled: true,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.welaya,
                  hintText: "16".tr,
                  enabled: true,
                ),
                CustemtextfromfildInfoUser(
                  myController: controller.numperphone,
                  hintText: "17".tr,
                  enabled: true,
                ),
                SizedBox(height: 50),
                Custemsuberbutton(
                  content: "تأكيد".tr,
                  color: AppColor.typography,
                  onPressed: () {
                    controller.edituser();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
