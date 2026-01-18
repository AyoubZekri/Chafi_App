import 'dart:async';

import 'package:chafi/core/constant/routes.dart';
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

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offNamed(Approutes.onBarding);
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
