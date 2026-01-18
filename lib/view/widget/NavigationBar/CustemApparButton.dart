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
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icondata,
            color: active == true ? AppColor.typography : AppColor.grey,
            size: 30,
          ),
          Text(
            textButton,
            style: TextStyle(
              color: active == true ? AppColor.typography : AppColor.grey,
            ),
          ),
        ],
      ),
    );
  }
}
