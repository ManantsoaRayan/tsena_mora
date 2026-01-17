import 'dart:convert';

import 'package:flutter/services.dart';

class ProductClass {
  String title;
  double price;
  String description;
  String image;
  double rating;

  ProductClass({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating

  });

  factory ProductClass.fromDescription(Map<String, dynamic> jsonDescription) {
    return ProductClass(
      title: jsonDescription['title'],
      price: jsonDescription['price'],
      description: jsonDescription['description'],
      image: jsonDescription['image'],
      rating: jsonDescription['rating']
    );
  }
}

class ProductModel {
  Future<List<ProductClass>> fetchDescription() async {
    final jsonStringDescription = await rootBundle.loadString(
      'assets/product.json',
    );
    final List dataDescription = json.decode(jsonStringDescription);
    return dataDescription.map((e) => ProductClass.fromDescription(e)).toList();
  }
}
