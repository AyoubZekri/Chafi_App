import 'dart:io';
import 'package:dns_client/dns_client.dart';

Future<bool> checkInternet() async {
  print("checkInternet");

  final dnsProviders = [
    DnsOverHttps.google(),      // DNS جوجل
    DnsOverHttps.cloudflare(),  // DNS كلاودفلير
    DnsOverHttps.dnsSb(),       // DNS Quad9
    DnsOverHttps.adguardNonFiltering(),       // DNS Quad9
  ];

  for (final dns in dnsProviders) {
    try {
      final result = await dns.lookup('google.com');
      if (result.isNotEmpty) {
        print("✅ DNS success via ${dns.runtimeType}");
        return true;
      }
    } catch (e) {
      print("⚠️ DNS failed via ${dns.runtimeType}: $e");
    }
  }

  return false; // كل المزودين فشلوا
}

