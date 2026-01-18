import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Custemcardhome extends StatelessWidget {
  final String image;
  final String content;

  const Custemcardhome({super.key, required this.image, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20,),
      width: 255,
      decoration: BoxDecoration(
        color: Color(0xffEFF5F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(20),
            child: Image.asset(
              image,
              width: 238,
              height: 159,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 230,
            child: Text(
              content,
              style: context.textTheme.bodyMedium?.copyWith(fontSize: 16),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
