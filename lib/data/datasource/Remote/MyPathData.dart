import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Mypathdata {
  Crud crud;
  Mypathdata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.mypathShow, data);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data) async {
    var response = await crud.postWithheaders(Applink.mypathadd, data);
    return response.fold((l) => l, (r) => r);
  }

  editdata(Map data) async {
    var response = await crud.postWithheaders(Applink.mypathedit, data);
    return response.fold((l) => l, (r) => r);
  }

  deletedata(Map data) async {
    var response = await crud.postWithheaders(Applink.mypathdelete, data);
    return response.fold((l) => l, (r) => r);
  }
}
