import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/models/orders.dart';

import 'components/body.dart';

class OrderDetails extends StatelessWidget {
  Orders curOrder;
  OrderDetails(this.curOrder);
  static String routeName = "/orderdetails";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Order Details"),
      ),
      body: Body(curOrder: this.curOrder,),
    );
  }
}
