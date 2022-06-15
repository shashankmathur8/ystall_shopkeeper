import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ystall_shopkeeper/dimensions.dart';
import 'package:ystall_shopkeeper/models/products.dart';

import '../../models/seller.dart';
import '../../widgets/IconAndText.dart';
import '../../widgets/bigtext.dart';

class appColumn extends StatelessWidget {
  final String text;

  List<Products> products=[];
  appColumn({Key? key,required this.text,required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bigText(stringText: text),
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
            iconandText(text: 'Add',
              iconColor: Colors.deepOrangeAccent,
              icon: Icons.plus_one,
            ),
            iconandText(text: '1.7Km',
              iconColor: Colors.blueGrey,
              icon: Icons.location_on,
            ),
            iconandText(text: '32min',
              iconColor: Colors.deepOrangeAccent,
              icon: Icons.timer,
            ),

          ],
        ),
        ListView.builder(
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
                              image: NetworkImage("https://media.istockphoto.com/vectors/placeholder-rgb-color-icon-vector-id1264040074?k=20&m=1264040074&s=612x612&w=0&h=ccNcaxrRPezYd2-dGiVELouA7VFLohJpwRIiKZHUpY0="))),


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
                                  iconandText(text: 'Edit',
                                    iconColor: Colors.black,
                                    icon: Icons.edit_outlined,
                                  ),
                                  iconandText(text: 'Remove',
                                    iconColor: Colors.black,
                                    icon: Icons.delete_outline,
                                  ),SizedBox(width: 10,),

                                ],
                              )

                            ],
                          ),
                        ),),
                    )
                  ],
                ),
              );
            })

      ],
    );
  }
}
