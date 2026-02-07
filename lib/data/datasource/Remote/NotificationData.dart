import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Notificationdata {
  Crud crud;
  Notificationdata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(
      Applink.notificationUserShow,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  deletedata(Map data) async {
    var response = await crud.postWithheaders(
      Applink.notificationUserdelete,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

  isReaddata(Map data) async {
    var response = await crud.postWithheaders(
      Applink.notificationUserIsRead,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }
}
