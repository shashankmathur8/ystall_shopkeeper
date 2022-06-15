
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/bigtext.dart';
import 'package:ystall_shopkeeper/models/seller.dart';
import 'package:ystall_shopkeeper/screens/homePage/app_Icon.dart';
import 'package:ystall_shopkeeper/screens/splash/splash_screen.dart';
import 'package:ystall_shopkeeper/widgets/AccountWidget.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ystall_shopkeeper/server/api.dart';

class SellerProfile extends StatelessWidget {
  SellerApi api = new SellerApi();
  static String routeName = "/profile";
  String email;
  String address;
  SellerProfile({Key? key, required this.email,required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: bigText(stringText: "Profile",size: 24,),
      ),
      body: Container(
        width: double.maxFinite,
        color: Colors.white,
        child: Column(
          children: [
            appIcon(icon: Icons.person,
              iconColor: Colors.deepOrangeAccent,
              bgColor: Colors.white,
              size: 75,),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.account_box,iconColor: Colors.deepOrangeAccent,),onPressed: ()=>{

            },), bigtext: bigText(stringText: this.email)),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.home,iconColor: Colors.deepOrangeAccent,),onPressed: ()=>{},), bigtext: bigText(stringText: this.address)),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.account_box_outlined,iconColor: Colors.deepOrangeAccent,),onPressed: ()=>{logout(context)},), bigtext: bigText(stringText: "Logout")),
            SizedBox(height: 50,),
            bigText(stringText: "For any other issues contact \n     developer@ystall.com")
          ],
        ),
      ),
    );
  }

   logout( BuildContext context) async{
    Box hivebox= await Hive.openBox('loginData');
    hivebox.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SplashScreen()));

  }
}
