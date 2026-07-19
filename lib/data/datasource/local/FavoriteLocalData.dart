import '../../../core/class/Sqldb.dart';

class FavoriteLocalData {
  SQLDB sqldb = SQLDB();

  Future<List<Map<String, dynamic>>> getFavorites() async {
    var db = await sqldb.db;
    return await db!.query('favorites');
  }

  Future<int> addFavorite(int itemId, String itemType) async {
    var db = await sqldb.db;
    return await db!.insert('favorites', {
      'item_id': itemId,
      'item_type': itemType,
    });
  }

  Future<int> removeFavorite(int itemId, String itemType) async {
    var db = await sqldb.db;
    return await db!.delete('favorites', where: 'item_id = ? AND item_type = ?', whereArgs: [itemId, itemType]);
  }
}
