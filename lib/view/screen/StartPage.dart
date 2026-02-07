import 'dart:async';

import 'package:chafi/core/constant/routes.dart';
import 'package:chafi/core/services/Services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constant/imageassets.DART';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  bool animate = false;
  Myservices myServices = Get.find();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (myServices.sharedPreferences!.getBool("onbording") == true) {
        if (myServices.sharedPreferences!.getString("email") == null) {
          Get.offNamed(Approutes.googleSignIn);
          return;
        } else {
          Get.offNamed(Approutes.navigationBar);
          return;
        }
      } else {
        Get.offNamed(Approutes.onBarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(Appimageassets.logo, height: 200)),
    );
  }
}
