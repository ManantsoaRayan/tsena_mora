import 'package:flutter/material.dart';
import 'package:tsena_mora/model/categorie_model.dart';

class ViewModelCategorie extends ChangeNotifier{

  CategorieModel modelCategorie  = CategorieModel();
  List <CategorieClass> listCategorie =[];
  bool isLoading = true;


  void fetchCategorie(){
    modelCategorie.fetchCategorie().then((listCat){
      listCategorie = listCat;
      isLoading = false;
      notifyListeners();  
    });
  }


  List <CategorieClass> get getListCategorie => listCategorie;

}