import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';
import 'dart:convert';

class FavoriteRemoteData {
  Crud crud;
  
  FavoriteRemoteData(this.crud);

  getFavoritesData(bool hasToken, List<Map<String, dynamic>> localFavorites) async {
    var response = await (hasToken
        ? crud.postWithheaders(Applink.favoritesShow, {"favorites": localFavorites})
        : crud.postWithout(Applink.favoritesShow, {"favorites": jsonEncode(localFavorites)}));
    return response.fold((l) => l, (r) => r);
  }
}
