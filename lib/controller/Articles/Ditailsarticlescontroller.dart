import 'package:get/get.dart';
import '../../core/class/Statusrequest.dart';
import '../../data/datasource/Remote/PostData.dart';
import '../../data/model/PostModel.dart';

class DitailsArticlesController extends GetxController {
  int? id;
  Postdata postdata = Postdata(Get.find());

  Statusrequest statusrequest = Statusrequest.none;
  List<PostModel> datapost = [];

  Future<void> viewdata() async {
    if (id == null) return;

    statusrequest = Statusrequest.loadeng;
    update();

    var response = await postdata.getLocalPosts({"type": 1});

    final postMap = response.firstWhere(
      (element) =>
          element['id'] == id || element['id'].toString() == id.toString(),
      orElse: () => <String, Object?>{},
    );

    if (postMap.isNotEmpty) {
      datapost = PostModel.fromJsonList(postMap);
      statusrequest = Statusrequest.success;
    } else {
      statusrequest = Statusrequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>;
    id = args["id"];
    viewdata();
    super.onInit();
  }
}
