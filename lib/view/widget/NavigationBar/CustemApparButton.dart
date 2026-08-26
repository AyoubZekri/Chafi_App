import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';

class Custemapparbutton extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;
  final IconData icondata;
  final bool? active;
  const Custemapparbutton({
    super.key,
    required this.onPressed,
    required this.icondata,
    required this.active,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      minWidth: 0,
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icondata,
            color: active == true ? AppColor.typography : AppColor.grey,
            size: 30,
          ),
          AutoSizeText(
            textButton,
            maxLines: 1,
            minFontSize: 8,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 12,
              color: active == true ? AppColor.typography : AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}
