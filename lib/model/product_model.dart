import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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
    required this.rating,
  });

  factory ProductClass.fromDescription(Map<String, dynamic> jsonDescription) {
    return ProductClass(
      title: jsonDescription['title'],
      price: jsonDescription['price'],
      description: jsonDescription['description'],
      image: jsonDescription['image'],
      rating: jsonDescription['rating'],
    );
  }
}

class ProductModel {
  Future<List<ProductClass>> fetchDescription() async {
    try {
      // Adresse pour émulateur Android (localhost du PC vu depuis émulateur)
      final response = await http.get(
        Uri.parse('http://192.168.0.218:8000/products/scores'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        return data.map((json) {
          return ProductClass(
            title: json['name'] ?? 'Produit inconnu',
            price: (json['price'] as num?)?.toDouble() ?? 0.0,
            description: json['description'] ?? '',
            image: json['image'] ?? '',
            rating:
                (json['score'] as num?)?.toDouble() ??
                0.0, // ← le score devient rating
          );
        }).toList();
      } else {
        print('Erreur API : ${response.statusCode}');
        return _loadFromAssetsFallback(); // fallback si backend HS
      }
    } catch (e) {
      print('Erreur connexion : $e');
      return _loadFromAssetsFallback(); // fallback en cas d'erreur réseau
    }
  }

  // Méthode fallback (l'ancien code JSON local)
  Future<List<ProductClass>> _loadFromAssetsFallback() async {
    final jsonString = await rootBundle.loadString('assets/product.json');
    final List data = json.decode(jsonString);
    return data.map((e) => ProductClass.fromDescription(e)).toList();
  }
}
