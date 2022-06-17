import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/models/orders.dart';
import 'package:ystall_shopkeeper/screens/OrdersDetails/OrderDetails.dart';
import 'package:ystall_shopkeeper/server/api.dart';

import '../../../models/orders.dart';
import '../../../models/seller.dart';
import '../orders.dart';

class Body extends StatefulWidget {
  Seller curseller;
  Body({Key? key,required this.curseller}) : super(key: key);

  @override
  State<Body> createState() => _BodyState(curseller);
}

class _BodyState extends State<Body> {
  late Future<String> hasDone;
  void initState() {
    super.initState();
    hasDone=getData();
  }
  Seller curseller;
  _BodyState(this.curseller);
  late List<Orders> Orderlist;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
                textDirection: TextDirection.ltr,
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            if(Orderlist.isEmpty){
              return Container(
                // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
                child: Center(
                  child: Text("No Orders",style: TextStyle(fontSize: 24),),
                ),
              );
            }else{
              return Container(
                // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: Orderlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return makeCard(Orderlist[index]);
                  },
                ),
              );
            }
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Center(
          child: CircularProgressIndicator(),
        );
      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: hasDone,
    );
  }
  Card makeCard(Orders od) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.deepOrangeAccent),
      child: makeListTile(od),
    ),
  );

  ListTile makeListTile(Orders od) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.autorenew, color: Colors.white),
    ),
    title: Text(
      od.userIdForUser,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

    subtitle: Row(
      children: [
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Rs ${od.amount}",
                  style: TextStyle(color: Colors.white,fontSize: 16))),
        ),
        Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("${od.deliveryAddress} - ${od.DeliveryPhone}",
                  style: TextStyle(color: Colors.white,fontSize: 16))),
        )
      ],
    ),
    trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> OrderDetails(od)));

    },
  );

  Future<String> getData() async {
    SellerApi api = new SellerApi();
    var ls=await api.getOrders();
    var temp=[];
    if(ls.isEmpty){
      return "notdone";
    }else{
      for(Orders x in ls){
        if(x.sellerEmail!=curseller.email){
          temp.add(x);
        }
      }
    }
    for(Orders x in temp){
      ls.remove(x);
    }
    this.Orderlist=ls;

    return "done";

  }
}
