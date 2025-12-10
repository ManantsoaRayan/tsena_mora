import 'package:flutter/material.dart';
import 'package:tsena_mora/model/descriptionModel.dart';

class ViewModelDescription extends ChangeNotifier{

  DescriptionModel modelDescription  = DescriptionModel();
  List <DescriptionClass> listDescription = [];
  bool isLoading = true;


  void fetchDescription(){
    modelDescription.fetchDescription().then((listDec){
      listDescription = listDec;
      isLoading = false;
      notifyListeners();  
    });
  }

  List <DescriptionClass> get getListDescription => listDescription;

}