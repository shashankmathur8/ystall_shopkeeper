import 'package:flutter/cupertino.dart';
class appIcon extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final double size;

  const appIcon({Key? key,
  required this.icon,
  this.bgColor=const Color(0xFFfcf4e4),
  this.iconColor= const Color(0xFF756d54),this.size =45
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
            color: bgColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: size,
      ),
    );
  }
}
