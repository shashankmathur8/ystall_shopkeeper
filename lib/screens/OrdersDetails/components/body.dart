import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/models/orders.dart';
import 'package:ystall_shopkeeper/server/api.dart';

import '../../../models/orders.dart';

class Body extends StatefulWidget {
  Orders curOrder;
  Body({Key? key,required this.curOrder}) : super(key: key);

  @override
  State<Body> createState() => _BodyState(curOrder);
}

class _BodyState extends State<Body> {
  Orders curOrder;

  _BodyState(this.curOrder);
  late List<Orders> Orderlist;
  @override
  Widget build(BuildContext context) {
    var p = curOrder.productList.substring(1,curOrder.productList.length-1).split(",");
    return ListView.builder(itemCount: p.length,itemBuilder: (context, index) {
      return ListTile(title: Text(p[index].trimLeft().trimRight()),);
    },);
  }

}
