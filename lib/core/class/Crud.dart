import 'dart:convert';
import 'dart:io';

import 'package:chafi/core/functions/Snacpar.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../functions/CheckInternat.dart';
import '../services/Services.dart';
import 'Statusrequest.dart';

class Crud {
  // =========================
  // Helpers (TOKEN + HEADERS)
  // =========================

  String? _getToken() {
    return Get.find<Myservices>().sharedPreferences?.getString("token");
  }

  Map<String, String> _jsonHeadersWithToken() {
    final token = _getToken();
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Map<String, String> _headersWithToken() {
    final token = _getToken();
    return {
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // =========================
  // POST JSON WITH TOKEN
  // =========================

  Future<Either<Statusrequest, Map>> postWithheaders(
    String linkurl,
    Map data,
  ) async {
    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.serverfailure);
      }

      final request = http.Request("POST", Uri.parse(linkurl));

      request.headers.addAll(_jsonHeadersWithToken());
      request.body = jsonEncode(data);

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      }

      print("❌ API Error: ${response.body}");
      return const Left(Statusrequest.failure);
    } catch (e) {
      print("❌ Exception postDataheaders: $e");
      return const Left(Statusrequest.failure);
    }
  }

  // =========================
  // POST LOGOUT (TOKEN ONLY)
  // =========================

  Future<Either<Statusrequest, Map>> postWithheadersLogout(
    String linkurl,
  ) async {
    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.serverfailure);
      }

      final request = http.Request("POST", Uri.parse(linkurl));

      request.headers.addAll(_headersWithToken());

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      }

      print("❌ Logout Error: ${response.body}");
      return const Left(Statusrequest.failure);
    } catch (e) {
      print("❌ Exception postDataheadersLogout: $e");
      return const Left(Statusrequest.failure);
    }
  }

  // =========================
  // POST WITHOUT TOKEN
  // =========================

  Future<Either<Statusrequest, Map>> postWithout(
    String linkurl,
    Map data,
  ) async {
    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.serverfailure);
      }

      final response = await http.post(
        Uri.parse(linkurl),
        headers: {"Accept": "application/json"},
        body: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      }

      print("❌ API Error: ${response.body}");
      return const Left(Statusrequest.failure);
    } catch (e, s) {
      print("❌ Exception postData: $e");
      print("🔍 $s");
      return const Left(Statusrequest.failure);
    }
  }

  // =========================
  // GET WITH TOKEN
  // =========================

  Future<Either<Statusrequest, Map>> getWithheaders(String linkurl) async {
    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.serverfailure);
      }

      final request = http.Request("GET", Uri.parse(linkurl));

      request.headers.addAll(_headersWithToken());
      print(
        "token ${Get.find<Myservices>().sharedPreferences?.getString("token")}",
      );

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      }

      print("❌ GET Error: ${response.body}");
      return const Left(Statusrequest.failure);
    } catch (e) {
      print("❌ Exception getData: $e");
      return const Left(Statusrequest.failure);
    }
  }

  // =========================
  // POST MULTIPART WITH TOKEN
  // =========================

  Future<Either<Statusrequest, Map>> addRequestWithImageOne(
    String url,
    Map data,
    int type,
    File? image, [
    String? namerequest,
  ]) async {
    type == 1 ? namerequest ??= "pdf" : namerequest ??= "image";

    try {
      if (!await checkInternet()) {
        return const Left(Statusrequest.serverfailure);
      }

      final request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers.addAll(_headersWithToken());

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            namerequest,
            image.path,
            filename: basename(image.path),
          ),
        );
      }

      data.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      }

      print("❌ Multipart Error: ${response.statusCode} - ${response.body}");
      return const Left(Statusrequest.failure);
    } catch (e) {
      print("❌ Exception addRequestWithImageOne: $e");
      return const Left(Statusrequest.failure);
    }
  }
}

// import 'dart:convert';
// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart';
// import 'package:dns_client/dns_client.dart';

// import '../functions/CheckInternat.dart';
// import '../services/Services.dart';
// import 'Statusrequest.dart';

// class Crud {
//   final DnsOverHttps dns = DnsOverHttps.google(); // أو Cloudflare

//   // =========================
//   // Helpers (TOKEN + HEADERS)
//   // =========================

//   String? _getToken() {
//     return Get.find<Myservices>().sharedPreferences?.getString("token");
//   }

//   Map<String, String> _jsonHeadersWithToken([String? host]) {
//     final token = _getToken();
//     final headers = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//       if (token != null) "Authorization": "Bearer $token",
//     };
//     if (host != null) headers["Host"] = host;
//     return headers;
//   }

//   Map<String, String> _headersWithToken([String? host]) {
//     final token = _getToken();
//     final headers = {
//       "Accept": "application/json",
//       if (token != null) "Authorization": "Bearer $token",
//     };
//     if (host != null) headers["Host"] = host;
//     return headers;
//   }

//   // =========================
//   // Resolve hostname via DNS
//   // =========================
//   Future<String> _resolveHost(String url) async {
//     final uri = Uri.parse(url);
//     final result = await dns.lookup(uri.host);
//     if (result.isEmpty) throw Exception("DNS lookup failed for ${uri.host}");
//     return result.first.address;
//   }

//   // =========================
//   // POST JSON WITH TOKEN
//   // =========================
//   Future<Either<Statusrequest, Map>> postWithheaders(
//     String linkurl,
//     Map data,
//   ) async {
//     try {
//       if (!await checkInternet())
//         return const Left(Statusrequest.serverfailure);

//       final uri = Uri.parse(linkurl);
//       final ip = await _resolveHost(linkurl);
//       final request = http.Request(
//         "POST",
//        uri,
//       );
//       request.headers.addAll(_jsonHeadersWithToken(uri.host));
//       request.body = jsonEncode(data);

//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right(jsonDecode(response.body));
//       }

//       print("❌ API Error: ${response.body}");
//       return const Left(Statusrequest.failure);
//     } catch (e) {
//       print("❌ Exception postWithheaders: $e");
//       return const Left(Statusrequest.failure);
//     }
//   }

//   // =========================
//   // POST WITHOUT TOKEN
//   // =========================
//   Future<Either<Statusrequest, Map>> postWithout(
//     String linkurl,
//     Map data,
//   ) async {
//     try {
//       if (!await checkInternet())
//         return const Left(Statusrequest.serverfailure);

//       final uri = Uri.parse(linkurl);
//       final ip = await _resolveHost(linkurl);
//       final response = await http.post(
//        uri,
//         headers: {"Accept": "application/json", "Host": uri.host},
//         body: data,
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right(jsonDecode(response.body));
//       }

//       print("❌ API Error: ${response.body}");
//       return const Left(Statusrequest.failure);
//     } catch (e) {
//       print("❌ Exception postWithout: $e");
//       return const Left(Statusrequest.failure);
//     }
//   }

//   // =========================
//   // POST LOGOUT (TOKEN ONLY)
//   // =========================
//   Future<Either<Statusrequest, Map>> postWithheadersLogout(
//     String linkurl,
//   ) async {
//     try {
//       if (!await checkInternet())
//         return const Left(Statusrequest.serverfailure);

//       final uri = Uri.parse(linkurl);
//       final ip = await _resolveHost(linkurl);
//       final request = http.Request(
//         "POST",
//        uri,
//       );
//       request.headers.addAll(_headersWithToken(uri.host));
//       print("========$request");

//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right(jsonDecode(response.body));
//       }

//       print("❌ Logout Error: ${response.body}");
//       return const Left(Statusrequest.failure);
//     } catch (e) {
//       print("❌ Exception postWithheadersLogout: $e");
//       return const Left(Statusrequest.failure);
//     }
//   }

//   // =========================
//   // GET WITH TOKEN
//   // =========================
//   Future<Either<Statusrequest, Map>> getWithheaders(String linkurl) async {
//     try {
//       if (!await checkInternet())
//         return const Left(Statusrequest.serverfailure);

//       final uri = Uri.parse(linkurl);
//       final ip = await _resolveHost(linkurl);
//       final request = http.Request(
//         "GET",
//        uri,
//       );
//       request.headers.addAll(_headersWithToken(uri.host));

//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right(jsonDecode(response.body));
//       }

//       print("❌ GET Error: ${response.body}");
//       return const Left(Statusrequest.failure);
//     } catch (e) {
//       print("❌ Exception getWithheaders: $e");
//       return const Left(Statusrequest.failure);
//     }
//   }

//   // =========================
//   // POST MULTIPART WITH TOKEN
//   // =========================
//   Future<Either<Statusrequest, Map>> addRequestWithImageOne(
//     String url,
//     Map data,
//     int type,
//     File? image, [
//     String? namerequest,
//   ]) async {
//     type == 1 ? namerequest ??= "pdf" : namerequest ??= "image";

//     try {
//       if (!await checkInternet())
//         return const Left(Statusrequest.serverfailure);

//       final uri = Uri.parse(url);
//       final ip = await _resolveHost(url);
//       final request = http.MultipartRequest(
//         "POST",
//        uri,
//       );
//       request.headers.addAll(_headersWithToken(uri.host));

//       if (image != null) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             namerequest,
//             image.path,
//             filename: basename(image.path),
//           ),
//         );
//       }

//       data.forEach((key, value) {
//         request.fields[key] = value.toString();
//       });

//       final streamed = await request.send();
//       final response = await http.Response.fromStream(streamed);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return Right(jsonDecode(response.body));
//       }

//       print("❌ Multipart Error: ${response.statusCode} - ${response.body}");
//       return const Left(Statusrequest.failure);
//     } catch (e) {
//       print("❌ Exception addRequestWithImageOne: $e");
//       return const Left(Statusrequest.failure);
//     }
//   }
// }
