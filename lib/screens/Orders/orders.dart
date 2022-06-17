import 'package:flutter/material.dart';

import '../../models/seller.dart';
import 'components/body.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = "/order";
  Seller curseller;
  OrdersScreen(this.curseller);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Order"),
      ),
      body: Body(curseller: this.curseller),
    );
  }
}
