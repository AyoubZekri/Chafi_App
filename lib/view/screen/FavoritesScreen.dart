import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/FavoritesController.dart';
import '../widget/Card/CustemCardinfo.dart';
import '../../core/class/Statusrequest.dart';
import '../../core/constant/Colorapp.dart';
import '../../core/class/handlingview.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة".tr),
        centerTitle: true,
      ),
      body: GetBuilder<FavoritesController>(
        builder: (controller) {
          return Handlingview(
            statusrequest: controller.statusrequest,
            title: "لا توجد بطاقات مفضلة حالياً".tr,
            widget: ListView.builder(
              itemCount: controller.favoritesList.length,
              itemBuilder: (context, index) {
                final favorite = controller.favoritesList[index];

                return Custemcardinfo(
                  title: favorite.title.isNotEmpty ? favorite.title : "بطاقة مفضلة",
                  body: favorite.body.isNotEmpty ? favorite.body : "لا يوجد نص متاح",
                  Calculator: favorite.hasCalcul,
                  Link: favorite.laws != null && favorite.laws!.isNotEmpty,
                  itemId: favorite.id,
                  type: favorite.type,
                  laws: favorite.laws,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
