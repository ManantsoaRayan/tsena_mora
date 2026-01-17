import 'package:flutter/material.dart';
import 'package:tsena_mora/model/product_model.dart';

class ViewModelProduct extends ChangeNotifier {
  ProductModel modelDescription = ProductModel();
  List<ProductClass> listDescription = [];
  bool isLoading = true;
  ProductClass? selectProduct;
  double priceDifference = 0.0;

  void fetchDescription() {
    modelDescription
        .fetchDescription()
        .then((listDec) {
          listDescription = listDec;
          isLoading = false;
          notifyListeners();
        })
        .catchError((e) {
          print("erreur $e");
        });
  }

  List<ProductClass> get getListDescription => listDescription;

  void selectdProduct(ProductClass product) {
    selectProduct = product;
    notifyListeners();
  }

  double comparateProduct(ProductClass productClass, double priceCompare) {
    return productClass.price - priceCompare;
  }
}
