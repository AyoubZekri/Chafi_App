import 'package:get/get.dart';
import '../core/class/Statusrequest.dart';
import '../core/services/Services.dart';
import '../core/class/Crud.dart';
import '../data/datasource/Remote/FavoriteRemoteData.dart';
import '../data/datasource/local/FavoriteLocalData.dart';
import '../data/model/FavoriteModel.dart';

class FavoritesController extends GetxController {
  FavoriteLocalData localData = FavoriteLocalData();
  late FavoriteRemoteData remoteData;
  Myservices myServices = Get.find();
  Statusrequest statusrequest = Statusrequest.none;
  
  List<FavoriteModel> favoritesList = [];
  List<Map<String, dynamic>> localFavoritesList = [];

  @override
  void onInit() {
    remoteData = FavoriteRemoteData(Get.find<Crud>());
    super.onInit();
    getFavorites();
  }

  Future<void> getFavorites() async {
    statusrequest = Statusrequest.loadeng;
    update();

    try {
      // 1. Fetch from SQLite
      List<Map<String, dynamic>> localFavorites = await localData.getFavorites();
      localFavoritesList = localFavorites;
      
      // 2. Fetch data from Server
      if (localFavorites.isNotEmpty) {
        bool hasToken = myServices.sharedPreferences?.getString("token") != null;
        var response = await remoteData.getFavoritesData(hasToken, localFavorites);

        if (response is Map && response['status'] == 200) {
          favoritesList = (response['data'] as List).map((e) => FavoriteModel(e)).toList();
          if (favoritesList.isEmpty) {
            statusrequest = Statusrequest.nodata;
          } else {
            statusrequest = Statusrequest.success;
          }
        } else {
          statusrequest = Statusrequest.serverfailure;
        }
      } else {
        favoritesList = [];
        statusrequest = Statusrequest.nodata;
      }
    } catch (e) {
      statusrequest = Statusrequest.serverfailure;
      print("Error fetching favorites: $e");
    }
    update();
  }

  Future<void> addFavorite(int itemId, String itemType) async {
    await localData.addFavorite(itemId, itemType);
    getFavorites(); // Refresh list
  }

  Future<void> removeFavorite(int itemId, String itemType) async {
    await localData.removeFavorite(itemId, itemType);
    getFavorites(); // Refresh list
  }

  bool isFavorite(int itemId, String itemType) {
    return localFavoritesList.any((element) => 
        element['item_id'].toString() == itemId.toString() && 
        element['item_type'].toString() == itemType.toString());
  }
}
