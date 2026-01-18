import 'package:chafi/core/constant/imageassets.dart';
import 'package:chafi/view/widget/Setting/CustemContactus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/Setting/CustemCardandTitle.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact us")),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              "تواصل معنا عبر",
              style: context.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            SizedBox(height: 20),
            SettingsCard(
              children: [
                SizedBox(height: 10),
                SectionTitle(title: "بيانات الإتصال"),
                Custemcontactus(
                  image: Appimageassets.phone,
                  title: "رقم الإتصال",
                  body: "+213661538484",
                  color: Colors.grey.shade200,
                  sizeImg: 24,
                  padding: 10,
                ),
                Custemcontactus(
                  image: Appimageassets.email,
                  title: " البريد اللإلكتروني",
                  body: "contact@Chafi.dz",
                  color: Colors.grey.shade200,
                  sizeImg: 24,
                  padding: 10,
                ),
              ],
            ),
            SizedBox(height: 20),
            SettingsCard(
              children: [
                SizedBox(height: 10),
                SectionTitle(title: "تواصل الإجتماعي"),
                Custemcontactus(
                  image: Appimageassets.instagram,
                  title: "إنستقرام",
                  body: "@Chafi",
                  color: Colors.white,
                  sizeImg: 50,
                  padding: 0,
                ),
                Custemcontactus(
                  image: Appimageassets.facebook,
                  title: "فايسبوك",
                  body: "@Chafi",
                  color: Colors.white,
                  sizeImg: 45,
                  padding: 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
