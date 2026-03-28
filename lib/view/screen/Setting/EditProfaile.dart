import 'package:chafi/controller/Setting/EditProfaileController.dart';
import 'package:chafi/core/class/Statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../widget/Button/CustemSuberButton.dart';
import '../../widget/TextFild/CustemTextFromFildInfoUser.dart';
import '../../widget/TextFild/Dropdownfild.dart';

class Editprofaile extends StatefulWidget {
  const Editprofaile({super.key});

  @override
  State<Editprofaile> createState() => _EditprofaileState();
}

class _EditprofaileState extends State<Editprofaile> {
  final controller = Get.put(EditprofailecontrollerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تعديل الملف الشخصي".tr)),
      body: GetBuilder<EditprofailecontrollerImp>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: 50),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 105),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: AppColor.primarycolor),
                    image: controller.image != null
                        ? DecorationImage(
                            image: FileImage(controller.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
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
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(83, 0, 0, 0),
                                  shape: BoxShape.circle,
                                ),
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
                          ],
                        ),
                ),
                SizedBox(height: 50),

                CustemtextfromfildInfoUser(
                  myController: controller.username,
                  hintText: "15".tr,
                  enabled: true,
                  iconData: Icons.person,
                ),
                // CustemtextfromfildInfoUser(
                //   myController: controller.welaya,
                //   hintText: "16".tr,
                //   enabled: true,
                //   iconData: Icons.location_on,
                // ),
                Dropdownfild(
                  hintText: "16".tr,
                  items: controller.state
                      .map(
                        (f) => DropdownMenuItem<String>(
                          value: f['state'].toString(),
                          child: Text(
                            "${f['number'].toString()} - ${f['state'].toString().tr}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  value: controller.selectedstate,
                  onChanged: (val) {
                    setState(() {
                      controller.selectedstate = val;
                    });
                  },
                ),

                CustemtextfromfildInfoUser(
                  myController: controller.numperphone,
                  hintText: "17".tr,
                  enabled: true,
                  iconData: Icons.phone,
                ),
                SizedBox(height: 50),
                controller.statusrequest == Statusrequest.loadeng
                    ? Custemsuberbutton(
                        laoding: true,
                        content: "تأكيد".tr,
                        color: AppColor.typography,
                      )
                    : Custemsuberbutton(
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
