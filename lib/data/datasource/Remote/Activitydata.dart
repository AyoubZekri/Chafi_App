import 'dart:io';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Activitydata {
  Crud crud;
  Activitydata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.activitysShwo, data);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data) async {
    var response = await crud.postWithheaders(Applink.activitysadd, data);
    return response.fold((l) => l, (r) => r);
  }

  
}
