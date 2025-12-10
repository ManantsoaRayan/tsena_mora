import 'package:flutter/material.dart';
import 'package:tsena_mora/model/tsenaMoraModel.dart';

class ViewModelDescription extends ChangeNotifier{

  TsenaMoraModel modelDescription  = TsenaMoraModel();
  List <TsenaMora> listDescription = [];
  bool isLoading = true;


  void fetchDescription(){
    modelDescription.fetchDescription().then((listDec){
      listDescription = listDec;
      isLoading = false;
      notifyListeners();  
    });
  }

  List <TsenaMora> get getListDescription => listDescription;

}