import 'package:chafi/view/screen/Law.dart';
import 'package:chafi/view/screen/Profaile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/Home.dart';
import '../view/screen/Records.dart';

abstract class NavigationBarcontroller extends GetxController {
  // ignore: non_constant_identifier_names
  ChangePage(int currentpage);
}

class NavigationBarcontrollerImp extends NavigationBarcontroller {
  int currentpage = 0;

  List<Widget> Screen = [
    const Home(),
    const Records(),
    const Law(),
    const Profaile(),
  ];

  List IconsScreen = [
    {'icon': Icons.home},
    {'icon': Icons.book},
    {'icon': Icons.article},
    {'icon': Icons.person},
  ];

  List Text = [
    {'Text': "Home"},
    {'Text': "Records"},
    {'Text': "Articles"},
    {'Text': "Profile"},
  ];

  @override
  ChangePage(int i) {
    currentpage = i;
    update();
  }
}
