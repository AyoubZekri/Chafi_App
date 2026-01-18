import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custemtextbodysmall extends StatelessWidget {
  final String content;
  const Custemtextbodysmall({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: context.textTheme.bodySmall,
    );
  }
}
