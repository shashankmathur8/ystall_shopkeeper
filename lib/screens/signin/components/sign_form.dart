import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/components/custom_surfix_icon.dart';
import 'package:ystall_shopkeeper/components/form_error.dart';
import 'package:ystall_shopkeeper/helper/keyboard.dart';
import 'package:ystall_shopkeeper/models/seller.dart';
import 'package:ystall_shopkeeper/screens/forgot_password/forgot_password_screen.dart';
import 'package:ystall_shopkeeper/screens/homePage/SellerHome.dart';
import 'package:ystall_shopkeeper/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import 'package:ystall_shopkeeper/server/api.dart';
import '../../../size_config.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../../sign_up/sign_up_screen.dart';
import '../sign_in_screen.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final SellerApi api= SellerApi();
  List<Seller> sellers=[];
  late Seller curSeller;
  final _formKey = GlobalKey<FormState>();
  String? email="";
  String? password="";
  String? emilFromHive;
  String? passFromHive;
  bool remember = false;
   late Box hivebox;
  final List<String?> errors = [];


  @override
  void initState()  {
    super.initState();
    createHiveBox();
    _loadContacts();
  }

  void _loadContacts() {
         api.getContacts().then((data) {
      if(this.mounted){
        setState(() {
          sellers = data;
        });
      }
    });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  bool checkValidityEmail(String email,String pass){
    _loadContacts();
    for(Seller s in sellers){
      if(s.email.toLowerCase()==email.toLowerCase()){
        if(s.pass==pass){
          this.curSeller=s;
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, SignUpScreen.routeName),
                child: Text(
                  "Sign Up",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
                // make call to using api
              bool valid=checkValidityEmail(email!,password!);
              if(valid){
                if(remember){
                  hivebox.put('email', email);
                  hivebox.put('pass', password);
                  hivebox.put('seller', curSeller);
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SellerHome(selleremail: this.curSeller.email,curseller: this.curSeller,)));
              }else{
                print('Wrong Password');
              }

            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
        initialValue: passFromHive,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) => password = value,

      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
        initialValue: emilFromHive,
      onSaved: (newValue) => this.email = newValue,
      onChanged: (value) => this.email = value,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void createHiveBox() async {
    hivebox = await Hive.openBox('loginData');
  }

}
