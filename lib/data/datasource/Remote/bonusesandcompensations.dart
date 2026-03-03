import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';

class Bonusesandcompensation{
  Crud crud;
  Bonusesandcompensation(this.crud);

  viewdata() async {
    var response = await crud.getWithheaders(Applink.bonusesandcompensations);
    return response.fold((l) => l, (r) => r);
  }
}
