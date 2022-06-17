
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ystall_shopkeeper/bigtext.dart';
import 'package:ystall_shopkeeper/models/seller.dart';
import 'package:ystall_shopkeeper/screens/Orders/orders.dart';
import 'package:ystall_shopkeeper/screens/homePage/app_Icon.dart';
import 'package:ystall_shopkeeper/screens/splash/splash_screen.dart';
import 'package:ystall_shopkeeper/widgets/AccountWidget.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ystall_shopkeeper/server/api.dart';

class SellerProfile extends StatelessWidget {
  SellerApi api = new SellerApi();
  static String routeName = "/profile";
  String locAdd="";
  late double long;
  late double latte;
  Seller curseller;
  SellerProfile({Key? key, required this.curseller,required this.locAdd,required this.long,required this.latte}) : super(key: key);

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
              _displayDialog(context,"email")
            },), bigtext: bigText(stringText: this.curseller.email)),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.home,iconColor: Colors.deepOrangeAccent,),onPressed: ()=>{
              _displayDialog(context,"address")
            },), bigtext: bigText(stringText: (this.curseller.address).split(",")[0])),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.phone_enabled,iconColor: Colors.deepOrangeAccent,),onPressed: () {
              _displayDialog(context,"number");
            },), bigtext: bigText(stringText: curseller.num)),
            AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.account_box_outlined,iconColor: Colors.deepOrangeAccent,),onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrdersScreen(this.curseller)));
            },), bigtext: bigText(stringText: "Orders")),
        AccountWidget(appicon: IconButton(icon: appIcon(icon: Icons.inbox,iconColor: Colors.deepOrangeAccent,),onPressed: (

            )=>{logout(context)},), bigtext: bigText(stringText: "Logout")),
            SizedBox(height: 50,),
            bigText(stringText: "For any other issues contact \n     developer@ystall.com")
          ],
        ),
      ),
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context,String action) async {
    if(action=="address"){
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter New Address'),
              content: TextField(
                controller: (_textFieldController..text=(this.locAdd.split(",")[0])),
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: "Address"),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    List<Location> locations =[] ;
                    locationFromAddress(_textFieldController.text).then((value) => locations=value);
                    this.curseller.address=_textFieldController.text.split(",")[0];
                    api.updateAddress(this.locAdd,curseller.email,this.long,this.latte);
                    Navigator.of(context).pop();
                  },
                ),

              ],
            );
          });
    }
    else if (action=="email"){

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter New Email'),
              content: TextField(
                controller: _textFieldController,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email"),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    api.updateEmail(_textFieldController.text,curseller.email);

                    this.curseller.email=_textFieldController.text;
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    else if (action=="number"){

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter New Number'),
              content: TextField(
                controller: _textFieldController,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Number"),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Submit'),
                  onPressed: () {
                    this.curseller.num=_textFieldController.text;
                    api.updateNumber(_textFieldController.text,curseller.email);
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

   logout( BuildContext context) async{
    Box hivebox= await Hive.openBox('loginData');
    hivebox.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SplashScreen()));

  }
}
