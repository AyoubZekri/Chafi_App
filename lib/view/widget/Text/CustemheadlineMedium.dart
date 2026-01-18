import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemheadlinemedium extends StatelessWidget {
  final String content;
  final Color color;

  const Custemheadlinemedium({
    super.key,
    required this.content,
    this.color = AppColor.white,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: context.textTheme.headlineMedium?.copyWith(color: color),
    );
  }
}
