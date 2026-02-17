import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../../LinkApi.dart';
import '../../../core/class/Crud.dart';
import '../../../core/class/Sqldb.dart';
import '../../../core/functions/CheckInternat.dart';

class Postdata {
  final Crud crud;
  final SQLDB db = SQLDB();

  Postdata(this.crud);
  Future<List> getLocalPosts(Map data) async {
    return await _getLocalPosts(data);
  }

  Future<List> viewdata(Map data) async {
    bool online = await checkInternet();
    print('===========================');
    if (!online) {
      return [];
    }
    print('===========================');

    var response = await crud.postWithheaders(Applink.postShow, data);
    print('===========================$response');

    return await response.fold(
      (l) async {
        return [];
      },
      (r) async {
        await _refreshLocalPosts(r['data']);
        return getLocalPosts(data);
      },
    );
  }
  // ================= LOCAL METHODS =================

  Future<void> _refreshLocalPosts(List posts) async {
    await db.delete('Post', null);

    for (var post in posts) {
      String? localImagePath;
      if (post['image'] != null && post['image'].toString().isNotEmpty) {
        localImagePath = await _downloadAndSaveImage(post['image'].toString());
      }
      print("=================$localImagePath");
      await db.insert('Post', {
        'id': post['id'],
        'image': localImagePath,
        'type': post['type'],
        'title': post['title'],
        'title2': post['title2'],
        'body': post['body'],
        'title_fr': post['title_fr'],
        'title2_fr': post['title2_fr'],
        'body_fr': post['body_fr'],
        'created_at': post['created_at'],
        'updated_at': post['updated_at'],
      });
    }
  }

  Future<List> _getLocalPosts(Map data) async {
    int type = data["type"];
    return await db.readData('SELECT * From Post Where type = $type');
  }

  // ================= IMAGE HANDLER =================

  Future<String> _downloadAndSaveImage(String url) async {
    try {
      final response = await http.get(Uri.parse("${Applink.image}$url"));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final fileName = url.split('/').last;
        final file = File('${dir.path}/$fileName');
        print("======================file$file");
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print("Error downloading image: $e");
    }
    return url;
  }
}
