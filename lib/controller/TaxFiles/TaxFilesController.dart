import 'package:get/get.dart';

import '../../core/class/Statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/Remote/TaxFilesData.dart';
import '../../data/model/TaxFileModel.dart';
import '../../view/screen/TaxFiles/TaxFileArticles.dart';

/// قائمة ملفات "جبايتك" (تحل محل صفحة القوانين)
class TaxFilesController extends GetxController {
  TaxFilesData taxFilesData = TaxFilesData(Get.find());
  Statusrequest statusrequest = Statusrequest.none;

  List<TaxDocumentModel> data = [];

  Future<void> viewdata() async {
    statusrequest = Statusrequest.loadeng;
    update();

    var response = await taxFilesData.viewDocuments();
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      if (response["status"] == 1 || response["status"] == true) {
        List listdata = response['data'];
        data = listdata.map((e) => TaxDocumentModel.fromJson(e)).toList();
        if (data.isEmpty) statusrequest = Statusrequest.nodata;
      } else {
        statusrequest = Statusrequest.failure;
      }
    }
    update();
  }

  void openFile(TaxDocumentModel document) {
    Get.to(() => TaxFileArticles(document: document));
  }

  @override
  void onInit() {
    viewdata();
    super.onInit();
  }
}
