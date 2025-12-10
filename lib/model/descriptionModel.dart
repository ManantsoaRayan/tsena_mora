import 'dart:convert';

import 'package:flutter/services.dart';

class DescriptionClass {

  String price;
  String description;
  String image;

  DescriptionClass({required this.price , required this.description, required this.image});

  factory DescriptionClass.fromDescription(Map<String, dynamic> jsonDescription){
    return DescriptionClass(
      price: jsonDescription['price'],
      description: jsonDescription['description'],
      image: jsonDescription['image']
    );
  }
}

class DescriptionModel {
    Future <List <DescriptionClass>> fetchDescription() async{
    final jsonStringDescription = await rootBundle.loadString('assets/description.json');
    final List dataDescription = json.decode(jsonStringDescription);
    return dataDescription.map((e) => DescriptionClass.fromDescription(e)).toList();
  }
}