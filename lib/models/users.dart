import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'users.g.dart';

@HiveType(typeId: 0)
class User {
    @HiveField(0)
    late String id;
    @HiveField(1)
    late  String name ;
    @HiveField(2)
    late String address;
    @HiveField(3)
    late String range;
    @HiveField(4)
    late String email;
    @HiveField(5)
    late String pass;
    @HiveField(6)
    late String num;
    @HiveField(7)
    late double long;
    @HiveField(8)
    late double latte;


    User(this.id,this.name, this.address, this.range, this.email, this.pass,this.num,this.long,this.latte);

  factory User.fromJson(Map json) {
      final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
      final name = json['name'];
      final address= json['address'];
      final email = json['email'];
      final pass= json['pass'];
      final range = json['range'];
      final num= json['num'];
      final long=json['long'];
      final latte=json['latte'];
      return User(id, name, address, range, email, pass,num,long,latte);
    }



}