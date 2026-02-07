
import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Appointmentscommitmentsdata {
  Crud crud;
  Appointmentscommitmentsdata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.appointmentsShow, data);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data) async {
    var response = await crud.postWithheaders(Applink.appointmentsadd, data);
    return response.fold((l) => l, (r) => r);
  }

}
