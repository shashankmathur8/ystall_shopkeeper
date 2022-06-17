import 'products.dart';
class Orders{
  late String id;
  late String orderNumber;
  late String productList;
  late int amount;
  late String userIdForUser;
  late String sellerId;
  late String sellerEmail;
  late String username;
  late String deliveryAddress;
  late String DeliveryPhone;

  Orders(this.id,this.orderNumber, this.productList, this.amount, this.userIdForUser,
      this.sellerId,this.sellerEmail,this.username,this.deliveryAddress,this.DeliveryPhone);
  factory Orders.fromJson(Map json) {
    final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final orderNumber = json['orderNumber'];
    final amount= json['cartprice'];
    final userIdForUser = json['useremail'];
    final sellerId= json['seller'];
    final sellerEmail=json['selleremail'];
    final username=json["user"];
    final productList= json['cartList'];
    final deliveryAddress=json['address'];
    final deliveryPhone=json['number'];
    return Orders(id, orderNumber,productList,amount,userIdForUser,sellerId,sellerEmail,username,deliveryAddress,deliveryPhone);
  }
}