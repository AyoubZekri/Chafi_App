import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/Colorapp.dart';

class Laws extends StatefulWidget {
  const Laws({super.key});

  @override
  State<Laws> createState() => _LawsState();
}

class _LawsState extends State<Laws> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Text('Laws Screen', style: context.textTheme.headlineMedium),
      ),
    );
  }
}
