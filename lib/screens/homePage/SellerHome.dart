import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ystall_shopkeeper/dimensions.dart';
import 'package:ystall_shopkeeper/main.dart';
import 'package:ystall_shopkeeper/models/products.dart';
import 'package:ystall_shopkeeper/screens/sellerProfile/SellerProfile.dart';
import 'package:ystall_shopkeeper/screens/signin/components/sign_form.dart';
import 'package:ystall_shopkeeper/server/api.dart';
import 'dart:io' as io;

import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../models/seller.dart';
import 'appColumn.dart';
import 'app_Icon.dart';

import '../../widgets/IconAndText.dart';
import '../../widgets/bigtext.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';




import 'package:flutter/cupertino.dart';

class SellerHome extends StatefulWidget {
  static String routeName = "/sellerhome";
  String selleremail="";
  Seller curseller;

   SellerHome({Key? key,required this.selleremail,required this.curseller}) : super(key: key);

  @override
  State<SellerHome> createState() => _SellerHomeState(selleremail,curseller);
}

class _SellerHomeState extends State<SellerHome> {
  String newProductQuantity="";
  late var ProductImage;
  String newProductPrice="";
  String newProductName="";
  String isUplopading="true";
  String newProductDesc="";
  late Future<List<Products>> productsMain;
  var value="";
  late Future<Seller> dataFuture;
  @override
  void initState(){
    super.initState();
    getLoc();
    dataFuture= waitforSeller();
    productsMain= _loadProducts();
  }


  Widget _buildPopupDialog(BuildContext context,String action,String id) {
    if(action== "add"){
      return new AlertDialog(
        scrollable: true,
        title:  Text("Add New Item"),
        actions: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Name',),
            onChanged: (value) => this.newProductName = value,

          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Price',),
            onChanged: (value) => this.newProductPrice = value,
              keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Description',),
            onChanged: (value) => this.newProductDesc = value,
          ),
          SizedBox(height: 10,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Quantity',),
            onChanged: (value) => this.newProductQuantity = value,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          ),
          new FlatButton(
            onPressed: () {
              getImage();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Add Image'),
          ),
          new FlatButton(
            onPressed: isUplopading!="false"?() {
              _addProduct(this.newProductName,this.newProductPrice,this.newProductQuantity,this.sellerEmail,this.newProductDesc,this.ProductImage);
              Navigator.of(context).pop();
              ;
            }:null,
            textColor: Theme.of(context).primaryColor,
            child: const Text('Add'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    else if(action == "range"){
      return new AlertDialog(
        title:  Text("Edit Delivery Range"),
        actions: <Widget>[
          TextField(
            controller: TextEditingController()..text = "",
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Range in km',),
            onChanged: (value) => this.value = value,
          ),
          new FlatButton(
            onPressed: () {
              updateRange(this.sellerEmail,this.value);
              curseller.range=value;
              Navigator.of(context).pop();
              ;
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Update'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    else if(action == "deliverytime"){
      return new AlertDialog(
        title:  Text("Edit Delivery Time"),
        actions: <Widget>[
          TextField(
            controller: TextEditingController()..text = "",
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Delivery Time in Min',),
            onChanged: (value) => this.value = value,
          ),
          new FlatButton(
            onPressed: () {
              updateDT(this.sellerEmail,this.value);
              curseller.time=value ;
              Navigator.of(context).pop();
              ;
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Update'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
    return new AlertDialog(
      title:  Text("general"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildPopupDialogedit(BuildContext context,String action,String id,Products product) {
    if(action == "edit"){
      return new AlertDialog(
        title:  Text("Edit Item ${product.productName}"),
        actions: <Widget>[
          TextField(
            controller: TextEditingController()..text = product.productName,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Name',
            ),
            onChanged: (value) => this.newProductName = value,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: TextEditingController()..text = product.price,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Price',),
            onChanged: (value) => this.newProductPrice = value,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: TextEditingController()..text = product.desc,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Description',),
            onChanged: (value) => this.newProductDesc = value,
          ),
          SizedBox(height: 10,),
          TextField(
            controller: TextEditingController()..text = product.quantity,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Quantity',),
            onChanged: (value) => this.newProductQuantity = value,
          ),
          new FlatButton(
            onPressed: () {
              api.updateItem(product.id,(this.newProductName==""?product.productName:this.newProductName),(this.newProductPrice==""?product.price:this.newProductPrice),(this.newProductQuantity==""?product.quantity:this.newProductQuantity),(this.newProductDesc==""?product.desc:this.newProductDesc));
              product.productName=this.newProductName==""?product.productName:this.newProductName;
              product.price= this.newProductPrice==""?product.price:this.newProductPrice;
              product.desc=this.newProductDesc==""?product.desc:this.newProductDesc;
              product.quantity= this.newProductQuantity==""?product.quantity:this.newProductQuantity;
              setState(() {
                products.removeWhere((product) => product.id == id);
                products.add(product);
              });
              Navigator.of(context).pop();
              ;
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Update'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
    }
      return new AlertDialog(
        title:  Text("general"),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Hello"),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Close'),
          ),
        ],
      );
  }

  SellerApi api = SellerApi();
  late var UploadDone;
  String sellerEmail;

  late String address;
  var longe;
  var latte;
  List<Products> products=[];
  List<Seller> sellers=[];
  late Seller  curseller;


  _SellerHomeState(this.sellerEmail, this.curseller);
  Future<List<Products>> _loadProducts() async {
    await api.getProductsbyUser(sellerEmail).then((data) {
      setState(() {
        products = data;
      });
    });

    return products;
  }
  Future<void> waitForProductsToLoad() async {
    while(this.products.isEmpty){
      products= await productsMain;
      await Future.delayed(Duration(seconds: 2));
    }
  }

  Future<Seller> waitforSeller() async{
    return this.curseller;


  }
  void deleteProducts (String id,String image) async{
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
    api.deleteProduct(id);
    await MyApp.ftpConnect.deleteFile(image);


  }

  void getLoc() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    this.address=first.addressLine;
    this.longe=position.longitude;
    this.latte=position.latitude;
  }

  void _addProduct(String ProductName,String Price,String Quantity , String sellerName ,String desc,var image) async {

    final createdProduct = await api.createProduct(
         ProductName,
         Price,
         Quantity,
         desc,
         "isBestSeller",
         "isAvailable",
    sellerName,image);
    setState(() {
      products.add(createdProduct);
    });
  }

  Future<void> UploadImage(productImage, BuildContext xyzcontext) async {
    setState(() {
      this.isUplopading="false";
    });
    UploadDone = this.api.uploadImage(productImage).then((value) => UploadDone=value);
    setState(() {
      this.isUplopading="true";
    });
  }

  @override
  Widget build(BuildContext context) {
   // waitForProductsToLoad();
    return FutureBuilder(
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
        if (true) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            return Scaffold(
              body: Stack(
                children: [
                  Positioned(left: 0,right: 0, child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image : NetworkImage("https://as1.ftcdn.net/v2/jpg/02/48/92/96/1000_F_248929619_JkVBYroM1rSrshWJemrcjriggudHMUhV.jpg")
                        )
                    ),
                  )),
                  Positioned(
                      top: 45,
                      left : 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(iconSize: 40,onPressed: ()=>{
                            //Goto Seller Profile page
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SellerProfile(curseller: this.curseller,locAdd: this.address,long: this.longe,latte: this.latte,)))

                          }, icon: appIcon(icon: Icons.person))

                        ],

                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 180,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,

                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bigText(stringText: curseller.name),
                              SizedBox(height: dimensions.height10,),
                              Row(
                                children: [
                                  Wrap(
                                    children: List.generate(5, (index) => Icon(Icons.star,color: Colors.blue,size: 15,)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  bigText(stringText: "4.5",size: 10,),
                                  SizedBox(width: 10,),
                                  bigText(stringText: "1287",size: 10,),
                                  SizedBox(width: 10,),
                                  bigText(stringText: "comments",size: 10,),

                                ],
                              ),
                              SizedBox(height: dimensions.height20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.add,color: Colors.black,),onPressed: ()=>{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => _buildPopupDialog(context,"add",""),)
                                      },),

                                      bigText(stringText: "Add",size: 15,color: Colors.black54,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.location_on,color: Colors.lightGreen,),onPressed: ()=>{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => _buildPopupDialog(context,"range","",),)
                                      },),

                                      bigText(stringText: curseller.range+" km",size: 15,color: Colors.black54,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.watch_later_outlined,color: Colors.deepOrange),onPressed: ()=>{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => _buildPopupDialog(context,"deliverytime","",),)
                                      },),

                                      bigText(stringText: curseller.time +" Min",size: 15,color: Colors.black54,)
                                    ],
                                  ),

                                ],
                              ),
                          FutureBuilder(
                            builder: (ctx, snapshot) {
                              // Checking if future is resolved or not
                              if(true){
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                      '${snapshot.error} occured',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  );

                                  // if we got our data
                                } else if (snapshot.hasData) {
                                  // Extracting data from snapshot object
                                  return ListView.builder(
                                      padding: EdgeInsets.only(top:05),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: products.length,
                                      itemBuilder: (context,index){
                                        return Container(
                                          margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(width : 60,height: 60,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                    color: Colors.black26,
                                                    border: Border.all(color: Colors.black),
                                                    image: DecorationImage(fit: BoxFit.fill,
                                                        image:NetworkImage("http://ystall.com/assets/imgs/" +products[index].image ))),


                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                      color: Colors.white
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(height: 5,),
                                                        bigText(stringText: products[index].productName == null ? 'SampleName' : products[index].productName ,size: 15,),
                                                        SizedBox(height: 5,),
                                                        bigText(stringText: products[index].desc == null ? 'SampleDesc' : products[index].desc,size: 15,color: Colors.black,),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            IconButton(icon: Icon(Icons.edit_outlined,color: Colors.black,),onPressed: ()=>{
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext context) => _buildPopupDialogedit(context,"edit",products[index].id,products[index]),)
                                                            },
                                                            ),
                                                            bigText(stringText: "Edit",size: 15,color: Colors.black54,),
                                                            Row(
                                                              children: [
                                                                IconButton(icon: Icon(Icons.delete_outline,color: Colors.black,),onPressed: ()=>{
                                                                  deleteProducts(products[index].id,products[index].image)
                                                                },),

                                                                bigText(stringText: "Remove",size: 15,color: Colors.black54,)
                                                              ],
                                                            ),
                                                          ],
                                                        )

                                                      ],
                                                    ),
                                                  ),),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                }

                              }

                              // Displaying LoadingSpinner to indicate waiting state
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },

                            // Future that needs to be resolved
                            // inorder to display something on the Canvas
                            future: productsMain,
                          )

                            ],
                          ),
                        ),

                      ))
                ],
              ),
            );
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return Center(
          child: CircularProgressIndicator(),
        );
      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: dataFuture,
    );
  }

  void updateRange(String email,range) {
    api.updateRange(email,range);

  }

  void updateDT(String sellerEmail, String value) {
    api.updateDT(sellerEmail,value);
  }

  Future<void> getImage() async {
    checkUpload(false,context);

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    ProductImage=image;

    await UploadImage(image,context);
    await Future.delayed(const Duration(seconds: 2), (){});
    checkUpload(true,context);

  }
  checkUpload(bool isUploadDone,BuildContext context){
    if(isUploadDone==false){
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Upload Is in Process'),
            content: SingleChildScrollView(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    }
    else{
      Navigator.of(context).pop();
    }

  }

}






