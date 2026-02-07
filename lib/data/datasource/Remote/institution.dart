import 'dart:io';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class InstitutionData {
  Crud crud;
  InstitutionData(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.institutionShow,data);
    return response.fold((l) => l, (r) => r);
  }

  idRead(Map data) async {
    var response = await crud.postWithheaders(Applink.institutionadd, data);
    return response.fold((l) => l, (r) => r);
  }
}
