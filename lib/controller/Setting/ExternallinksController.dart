import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Externallinkscontroller extends GetxController {
  Future<void> openUrl(String url) async {}
}

class ExternallinkscontrollerImp extends Externallinkscontroller {
  @override
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
