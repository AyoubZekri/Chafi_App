
import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Taxandappdata {
  Crud crud;
  Taxandappdata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.taxAndAppShwo, data);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data) async {
    var response = await crud.postWithheaders(
      Applink.taxAndAppadd,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

}
