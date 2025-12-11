import 'dart:convert';

import 'package:flutter/services.dart';

class ProductClass {

  String price;
  String description;
  String image;

  ProductClass({required this.price , required this.description, required this.image});

  factory ProductClass.fromDescription(Map<String, dynamic> jsonDescription){
    return ProductClass(
      price: jsonDescription['price'],
      description: jsonDescription['description'],
      image: jsonDescription['image']
    );
  }
}

class ProductModel {
    Future <List <ProductClass>> fetchDescription() async{
    final jsonStringDescription = await rootBundle.loadString('assets/product.json');
    final List dataDescription = json.decode(jsonStringDescription);
    return dataDescription.map((e) => ProductClass.fromDescription(e)).toList();
  }
}