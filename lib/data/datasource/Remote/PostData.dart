import 'dart:io';

import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Postdata {
  Crud crud;
  Postdata(this.crud);

  viewdata(Map data) async {
    var response = await crud.postWithheaders(Applink.postShow,data);
    return response.fold((l) => l, (r) => r);
  }

  adddata(Map data, File file) async {
    var response = await crud.addRequestWithImageOne(
      Applink.postadd,
      data,
      2,

      file,
    );
    return response.fold((l) => l, (r) => r);
  }

}
