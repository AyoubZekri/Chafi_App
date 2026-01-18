import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Builddeadlinetile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function()? ontap;
  const Builddeadlinetile({
    super.key,
    this.icon,
    required this.title,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Color(0xFF1F1F39)),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      // trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: ontap,
    );
  }
}
