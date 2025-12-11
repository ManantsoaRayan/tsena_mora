import 'package:flutter/material.dart';
import 'package:tsena_mora/model/productModel.dart';

class ViewModelProduct extends ChangeNotifier{

  ProductModel modelDescription  = ProductModel();
  List <ProductClass> listDescription = [];
  bool isLoading = true;


  void fetchDescription(){
    modelDescription.fetchDescription().then((listDec){
      listDescription = listDec;
      isLoading = false;
      notifyListeners();  
    });
  }

  List <ProductClass> get getListDescription => listDescription;

}