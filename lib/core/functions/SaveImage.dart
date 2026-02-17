import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File?> downloadAndCacheImage(String imageUrl) async {
  try {
    if (imageUrl.isEmpty) return null;

    final directory = await getApplicationDocumentsDirectory();

    // اسم الصورة من الرابط
    final fileName = imageUrl.split('/').last;
    final filePath = "${directory.path}/images/$fileName";

    final file = File(filePath);

    // إذا الصورة مخزنة من قبل → رجعها مباشرة
    if (await file.exists()) {
      return file;
    }

    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      await file.parent.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    }

    return null;
  } catch (e) {
    print("Image cache error: $e");
    return null;
  }
}
