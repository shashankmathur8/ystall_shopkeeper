import 'package:flutter/cupertino.dart';

class Seller{
    late String id;
    late  String name ;
    late String address;
    late String time;
    late String range;
    late String email;
    late String pass;

    Seller(this.id,this.name, this.address, this.time, this.range, this.email, this.pass);

  factory Seller.fromJson(Map json) {
      final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
      final name = json['name'];
      final address= json['address'];
      final email = json['email'];
      final pass= json['pass'];
      final range = json['range'];
      final time = json['time'];
      return Seller(id, name, address, time, range, email, pass);
    }



}