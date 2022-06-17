import 'package:flutter/cupertino.dart';

import 'package:hive/hive.dart';
part 'seller.g.dart';

@HiveType(typeId: 0)
class Seller{
    @HiveField(0)
    late String id;
    @HiveField(1)
    late  String name ;
    @HiveField(2)
    late String address;
    @HiveField(3)
    late String time;
    @HiveField(4)
    late String range;
    @HiveField(5)
    late String email;
    @HiveField(6)
    late String pass;
    @HiveField(7)
    late String num;
    @HiveField(8)
    late double long;
    @HiveField(8)
    late double latte;

    Seller(this.id,this.name, this.address, this.time, this.range, this.email, this.pass,this.num,this.long,this.latte);

  factory Seller.fromJson(Map json) {
      final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
      final name = json['name'];
      final address= json['address'];
      final email = json['email'];
      final pass= json['pass'];
      final range = json['range'];
      final time = json['time'];
      final num= json['num'];
      final long=json['long'];
      final latte=json['latte'];
      return Seller(id, name, address, time, range, email, pass,num,long,latte);
    }



}