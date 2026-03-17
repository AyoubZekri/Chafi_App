import 'package:chafi/core/constant/Imageassets.dart';
import 'package:chafi/view/widget/Setting/CustemContactus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widget/Setting/CustemCardandTitle.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  void _launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // فتح البريد الإلكتروني
  void _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // فتح روابط خارجية (Instagram, Facebook)
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact us".tr)),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "تواصل معنا عبر".tr,
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 20),
            SettingsCard(
              children: [
                SizedBox(height: 10),
                SectionTitle(title: "بيانات الإتصال".tr),
                Custemcontactus(
                  image: Appimageassets.phone,
                  title: "رقم الإتصال".tr,
                  body: "+213661538484",
                  color: Colors.grey.shade200,
                  sizeImg: 24,
                  padding: 10,
                  ontap: () {
                    _launchPhone("+213661538484");
                  },
                ),
                Custemcontactus(
                  image: Appimageassets.email,
                  title: " البريد اللإلكتروني".tr,
                  body: "contact@Chafi.dz",
                  color: Colors.grey.shade200,
                  sizeImg: 24,
                  padding: 10,
                  ontap: () {
                    _launchEmail("ayobzekri670@gmail.com");
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            SettingsCard(
              children: [
                SizedBox(height: 10),
                SectionTitle(title: "تواصل الإجتماعي".tr),
                Custemcontactus(
                  image: Appimageassets.instagram,
                  title: "إنستقرام".tr,
                  body: "@Chafi",
                  color: Colors.white,
                  sizeImg: 50,
                  padding: 0,
                  ontap: () {
                    _launchURL(
                      "https://www.instagram.com/ayoub.zekri_?igsh=MTRmcnd6M215OTFnMQ==",
                    );
                  },
                ),
                Custemcontactus(
                  image: Appimageassets.facebook,
                  title: "فايسبوك".tr,
                  body: "@Chafi",
                  color: Colors.white,
                  sizeImg: 45,
                  padding: 0,
                  ontap: () {
                    _launchURL("@Chafi");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
