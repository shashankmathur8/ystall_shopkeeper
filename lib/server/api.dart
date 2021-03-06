import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:ystall_shopkeeper/main.dart';
import 'package:ystall_shopkeeper/models/orders.dart';
import 'package:ystall_shopkeeper/models/products.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ystall_shopkeeper/models/users.dart';


import '../models/seller.dart';

class SellerApi {
  static final Map<String, String> httpHeaders = {
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };
  final _dio = Dio(BaseOptions(baseUrl: 'http://194.163.43.152:8081',headers: httpHeaders));

  Future<List<Seller>> getContacts() async {
    final response = await _dio.get('');
    return (response.data['sellers'] as List)
        .map<Seller>((json) => Seller.fromJson(json))
        .toList();
  }

  Future<List<Orders>> getOrders() async {
    final response = await _dio.get('/orders');
    return (response.data['orders'] as List)
        .map<Orders>((json) => Orders.fromJson(json))
        .toList();
  }

  Future<void> updateEmail(String newEmail, String prevEmail) async {
    final response = await _dio.post('/SellerEmail/${prevEmail}', data: {'email': newEmail});
    return response.data;
  }
  Future<void> updateAddress(String newAdd, String prevEmail,double long,double latte) async {
    final response = await _dio.post('/SellerAddress/${prevEmail}', data: {'address': newAdd,"long":long,"latte":latte});
    return response.data;
  }
  Future<void> updateNumber(String newNumber, String prevEmail) async {
    final response = await _dio.post('/SellerNum/${prevEmail}', data: {'num': newNumber});
    return response.data;
  }

  Future<List<Products>> getProducts() async {
    final response = await _dio.get('/products');
    return (response.data['products'] as List)
        .map<Products>((json) => Products.fromJson(json))
        .toList();
  }

  TriggerDistanceBuild() async{
    List<Seller> selList= await this.getContacts();
    List<User> userList= await this.getUsers();
    var data = Map();

    for(var usr in userList){
      for(Seller temo in selList){
        var distance= await Geolocator.distanceBetween(temo.long, temo.latte,usr.long, usr.latte);
        data[temo.email]=distance;
      }
      this.saveDistanceMap(data,usr.email);
    }

  }

  saveDistanceMap(var x,String email) async {

    final response = await _dio.post('/updateDistanceMap/$email', data: {"email":email,"distanceMap":x});

  }

  Future<List<User>> getUsers() async {
    final response = await _dio.get('/getUsers');
    return (response.data['users'] as List)
        .map<User>((json) => User.fromJson(json))
        .toList();
  }

  Future<List<Products>> getProductsbyUser(String email) async {
    final response = await _dio.get('/products/${email}');
    return (response.data['products'] as List)
        .map<Products>((json) => Products.fromJson(json))
        .toList();
  }

  Future<Seller> createContact(String name,String email,String password,String address, var long,var latte,String phone) async {
    final response = await _dio.post('/selleradd', data: {'name': name,"email":email,"pass":password,"address":address,"range":"5","time":"20","long":long,"latte":latte,"num":phone});
    TriggerDistanceBuild();
    return Seller.fromJson(response.data);
  }
  Future<String> uploadImage(var image)async {
    await MyApp.ftpConnect.connect();
    bool res = await MyApp.ftpConnect.uploadFile(image);
    return res.toString();
  }
  Future<Products> createProduct(
      String productName,
      String price,
      String quantity,
      String desc,
      String isBestSeller,
      String isAvailable,String sellerName,var image) async {


    String fileName = image.path.split('/').last;
    final response = await _dio.post('/productsadd', data: {
      'productName': productName,
      'price':price,
      'quantity':quantity
      ,'desc':desc,
      'isBestSeller':'false',
      'isAvailable':'true',
      'sellerName':sellerName,
      'image':fileName});
    Map json= response.data;
    return Products.fromJson({'_id':json['insertedId'],'productName': productName,'price':price,'quantity':quantity,'desc':desc,'isBestSeller':'false','isAvailable':'true',"image":fileName});
  }


  Future deleteContact(String id) async {
    final response = await _dio.delete('/$id');
    return response.data;
  }
  Future deleteProduct(String id) async {
    final response = await _dio.delete('/product/$id');
    return response.data;
  }
  Future updateItem(String id,String name,String price,String quantity,String desc) async {
    final response = await _dio.post('/productsUpdate/${id}', data: {'productName': name,'price':price,'quantity':quantity,'desc':desc});

    return response.data;
  }

  Future<void> updateRange(String email, range) async {
    final response = await _dio.post('/sellerRange/${email}', data: {'range': range});

    return response.data;
  }

  Future<void> updateDT(String sellerEmail, String value) async {
    final response = await _dio.post('/sellerDT/${sellerEmail}', data: {'time': value});

    return response.data;
  }

}