import 'package:flutter/material.dart';
import 'package:tsena_mora/model/tsenaMoraModel.dart';

class ViewModelCategorie extends ChangeNotifier{

  TsenaMoraModel modelCategorie  = TsenaMoraModel();
  List <TsenaMora> listCategorie =[];
  bool isLoading = true;


  void fetchCategorie(){
    modelCategorie.fetchCategorie().then((listCat){
      listCategorie = listCat;
      isLoading = false;
      notifyListeners();  
    });
  }


  List <TsenaMora> get getListCategorie => listCategorie;

}