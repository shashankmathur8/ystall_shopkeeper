import 'package:flutter/widgets.dart';
import 'package:ystall_shopkeeper/screens/homePage/SellerHome.dart';
import 'package:ystall_shopkeeper/screens/login_success/login_success_screen.dart';
import 'package:ystall_shopkeeper/screens/sellerProfile/SellerProfile.dart';
import 'package:ystall_shopkeeper/screens/sign_up/sign_up_screen.dart';
import 'package:ystall_shopkeeper/screens/signin/sign_in_screen.dart';
import 'package:ystall_shopkeeper/screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  SignUpScreen.routeName:(context) => SignUpScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
};
