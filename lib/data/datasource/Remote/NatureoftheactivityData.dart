import 'dart:io';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Natureoftheactivitydata {
  Crud crud;
  Natureoftheactivitydata(this.crud);

  viewdata() async {
    var response = await crud.getWithheaders(Applink.nataireActivitysShwo);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data) async {
    var response = await crud.postWithheaders(
      Applink.nataireActivitysadd,
      data,
    );
    return response.fold((l) => l, (r) => r);
  }

}
