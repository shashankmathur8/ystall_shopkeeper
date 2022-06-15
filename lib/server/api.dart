import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:ystall_shopkeeper/main.dart';
import 'package:ystall_shopkeeper/models/products.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';


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
  Future<List<Products>> getProducts() async {
    final response = await _dio.get('/products');
    return (response.data['products'] as List)
        .map<Products>((json) => Products.fromJson(json))
        .toList();
  }
  Future<List<Products>> getProductsbyUser(String email) async {
    final response = await _dio.get('/products/${email}');
    return (response.data['products'] as List)
        .map<Products>((json) => Products.fromJson(json))
        .toList();
  }

  Future<Seller> createContact(String name,String email,String password) async {
    final response = await _dio.post('/selleradd', data: {'name': name,"email":email,"pass":password,"address":"Vaisahli Nagar","range":"5","time":"20"});
    return Seller.fromJson(response.data);
  }
  Future<String> uploadImage(var image)async {
    await MyApp.ftpConnect.connect();
    bool res = await MyApp.ftpConnect.uploadFile(image);
    return "upload Done";
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