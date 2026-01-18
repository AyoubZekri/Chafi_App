import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustemtextbodyMedium18 extends StatelessWidget {
  final String content;
  final Color color;
  const CustemtextbodyMedium18({super.key, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyMedium?.copyWith(fontSize: 18,color: color),
    );
  }
}
