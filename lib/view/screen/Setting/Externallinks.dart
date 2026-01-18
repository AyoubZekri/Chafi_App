import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/Setting/ExternallinksController.dart';
import '../../../core/constant/Colorapp.dart';
import '../../widget/Setting/CustemCardExternallinks.dart';

class Externallinks extends StatefulWidget {
  const Externallinks({super.key});

  @override
  State<Externallinks> createState() => _ExternallinksState();
}

class _ExternallinksState extends State<Externallinks> {
  @override
  Widget build(BuildContext context) {
    Get.put(ExternallinkscontrollerImp());
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(title: Text("روابط خارجية".tr)),
      body: GetBuilder<ExternallinkscontrollerImp>(
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, i) {
                return Custemcardexternallinks(
                  body: "موقع دفع الضرائب",
                  color: const Color.fromARGB(30, 0, 0, 0),
                  ontap: () {
                    controller.openUrl("https://www.mfdgi.gov.dz");
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
