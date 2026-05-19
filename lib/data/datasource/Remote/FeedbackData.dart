import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class FeedbackData {
  Crud crud;
  FeedbackData(this.crud);

  addFeedback(List<int> types) async {
    var response = await crud.postWithheaders(Applink.addFeedback, {
      "types": types,
    });
    return response.fold((l) => l, (r) => r);
  }
}
