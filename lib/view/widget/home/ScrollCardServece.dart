import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/datasource/statec/statec.dart';
import '../Button/CustemCardButtonServices.dart';

class Scrollcardservece extends StatelessWidget {
  const Scrollcardservece({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: Cardservices.length,
      itemBuilder: (context, i) {
        return Custemcardbuttonservices(
          title: Cardservices[i].title!,
          image: Cardservices[i].image!,
          color: Cardservices[i].color!,
          color2: Cardservices[i].color2,
          onTap: Cardservices[i].onTap,
          height: 85,
          width: double.infinity,
        );
      },
    );
  }
}
