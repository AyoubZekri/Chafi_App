import 'package:flutter/widgets.dart';

class Cardservicesmodel {
  final String ?title;
  final String? image;
  final Color? color;
  final Color? color2;

  final void Function()? onTap;



  Cardservicesmodel({this.title,this.image,this.color, this.onTap, this.color2});
  
}