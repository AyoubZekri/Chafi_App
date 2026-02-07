import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Custemcardconferm extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  const Custemcardconferm({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "18".tr,
            style: context.textTheme.headlineSmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.grey,
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: Colors.blue[100],
            activeColor: Colors.blue[900],
            activeThumbColor: const Color.fromARGB(255, 130, 129, 129),
          ),
        ],
      ),
    );
  }
}
