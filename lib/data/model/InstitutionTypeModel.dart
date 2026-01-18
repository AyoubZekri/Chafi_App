import 'package:flutter/material.dart';

class Institutiontypemodel {
  final String body;
  final String imgae;
  final Color color1;
  final Color color2;
  final double sizeText;
  final void Function()? ontap;
  Institutiontypemodel({
    required this.imgae,
    required this.color1,
    required this.color2,
    required this.sizeText,
    required this.body,
    this.ontap,
  });
}
