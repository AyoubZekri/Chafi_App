import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custemtextbodylarge extends StatelessWidget {
  final String content;
  const Custemtextbodylarge({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge,
    );
  }
}
