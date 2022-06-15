import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/bigtext.dart';
import 'package:ystall_shopkeeper/screens/homePage/app_Icon.dart';

class AccountWidget extends StatelessWidget {
  IconButton appicon;
  bigText bigtext;
  AccountWidget({Key? key,required this.appicon,required this.bigtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          offset: Offset(0,5),
        )],
      ),
      padding: EdgeInsets.only(left: 20,top: 20,bottom: 20),
      child: Row(
        children: [
          appicon,
        SizedBox(width: 20,),
          bigtext
        ],
      ),
    );
  }
}
