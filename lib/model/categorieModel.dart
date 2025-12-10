import 'dart:convert';

import 'package:flutter/services.dart';

class CategorieClass{

  String categorie;
  String imageCategorie;

  CategorieClass({required this.categorie, required this.imageCategorie});

    factory CategorieClass.fromCategorie(Map<String, dynamic> jsonCategorie){
    return CategorieClass(
      categorie: jsonCategorie['categorie'],
      imageCategorie: jsonCategorie['imageCategorie']
    );
  }

}

class CategorieModel {
    Future <List <CategorieClass>> fetchCategorie() async{
    final jsonStringCategorie = await rootBundle.loadString('assets/categorie.json');
    final List dataCategorie = json.decode(jsonStringCategorie);
    return dataCategorie.map((e) => CategorieClass.fromCategorie(e)).toList();
  }
}