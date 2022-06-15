import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:ystall_shopkeeper/models/seller.dart';

class SellerHive extends HiveObject{
    late String id;
    late  String name ;
    late String address;
    late String time;
    late String range;
    late String email;
    late String pass;

   // SellerHive(this.id,this.name, this.address, this.time, this.range, this.email, this.pass);
     SellerHive(Seller s){
        this.id=s.id;
        this.name=s.name;
        this.address=s.address;
        this.time=s.time;
        this.range=s.range;
        this.email=s.email;
        this.pass=s.pass;
    }
}