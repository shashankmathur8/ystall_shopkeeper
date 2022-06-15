import 'products.dart';
class Orders{
  late String orderNumber;
  late List<Products> productList;
  late int amount;
  late String userIdForUser;
  late String sellerId;

  Orders(this.orderNumber, this.productList, this.amount, this.userIdForUser,
      this.sellerId);
}