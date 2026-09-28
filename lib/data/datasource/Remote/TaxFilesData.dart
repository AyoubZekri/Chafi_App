import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

/// ملفات "جبايتك" ومواد كل ملف
class TaxFilesData {
  Crud crud;
  TaxFilesData(this.crud);

  viewDocuments() async {
    var response = await crud.postWithout(Applink.taxDocumentsShow, {});
    return response.fold((l) => l, (r) => r);
  }

  viewArticles(int documentId) async {
    var response = await crud.postWithout(Applink.taxArticlesShow, {
      "document_id": documentId.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
