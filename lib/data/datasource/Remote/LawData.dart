import 'dart:io';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Lawdata {
  Crud crud;
  Lawdata(this.crud);

  viewdata() async {
    var response = await crud.getWithheaders(Applink.lawShow);
    return response.fold((l) => l, (r) => r);
  }

}
