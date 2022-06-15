

class Products{
  late String id;
  late String productName;
  late String price;
  late String quantity;
  late String desc;
  late String isBestSeller;
  late String isAvailable;
  late String image;

  Products(this.id,this.productName, this.price, this.quantity, this.desc,
      this.isBestSeller, this.isAvailable,this.image);

  factory Products.fromJson(Map json) {
    final id = json['_id'].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final productName = json['productName'];
    final price= json['price'];
    final quantity = json['quantity'];
    final desc= json['desc'];
    final isBestseller = json['isBestSeller'];
    final isAvailable = json['isAvaileble'];
    final image=json['image'];
    return Products(id, productName,price,quantity,desc,isBestseller,isAvailable,image);
  }
}