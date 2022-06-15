import 'package:flutter/cupertino.dart';

class bigText extends StatelessWidget {
  Color? color;
  final String stringText;
  double size;
  TextOverflow overflow;
  bigText({Key? key, this.color = const Color(0xFF332d2b), required this.stringText,
  this.overflow=TextOverflow.ellipsis,this.size=20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      stringText,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size
      ),

    );
  }
}
