import 'package:chafi/core/constant/routes.dart';
import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/services/Services.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../data/model/PostModel.dart';

abstract class Articlescontroller extends GetxController {
  void gotoditailsarticles(int id) {}
}

class ArticlescontrollerImp extends Articlescontroller {
  Myservices myServices = Get.find();

  Postdata postdata = Postdata(Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<PostModel> dataimg = [];
  List<PostModel> datapost = [];
  int currenpage = 0;

  Future<void> loadPosts({
    required int type,
    required List<PostModel> targetList,
  }) async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await postdata.getLocalPosts({"type": type});

    if (response.isNotEmpty) {
      targetList.clear();
      targetList.addAll(response.map((e) => PostModel.fromJson(e)));

      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    loadPosts(type: 1, targetList: datapost);
    super.onInit();
  }

  @override
  gotoditailsarticles(int id) {
    Get.toNamed(Approutes.ditailsarticles, arguments: {"id": id});
  }
}
