import 'dart:convert';

import 'package:flutter/services.dart';

class TsenaMora{
  String userName;
  String password;
  String price;
  String description;
  String image;
  String categorie;
  String imageCategorie;

  TsenaMora({
    this.userName = '',
    this.password = '',
    this.price = '',
    this.description = '',
    this.image = '',
    this.categorie = '',
    this.imageCategorie = ''

  });


  factory TsenaMora.fromCategorie(Map<String, dynamic> jsonCategorie){
    return TsenaMora(
      categorie: jsonCategorie['categorie'],
      imageCategorie: jsonCategorie['imageCategorie']
    );
  }

    factory TsenaMora.fromDescription(Map<String, dynamic> jsonDescription){
    return TsenaMora(
      price: jsonDescription['price'],
      description: jsonDescription['description'],
      image: jsonDescription['image']
    );
  }


}

class TsenaMoraModel {
  List <TsenaMora> userList = [TsenaMora(userName: 'Alice',)];
  List <TsenaMora> passwordList = [TsenaMora(password: '1234',)];

  List <TsenaMora> get getUserList => List.unmodifiable(userList);
  List <TsenaMora> get getPasswordList => List.unmodifiable(passwordList);

  void addUser(String user) {
    userList.add(TsenaMora(userName: user));
  }

  void addPassword(String password) {
    passwordList.add(TsenaMora(password: password));
  }

 bool authenticateUser(String userName) {
    //retourne true si l'utilisateur existe dans la liste
    return userList.any((user) => user.userName == userName);
  }

  bool authenticatePassword(String password) {
    //retourne true si le mot de passe existe dans la liste
    return passwordList.any((pass) => pass.password == password);
  }


  Future <List <TsenaMora>> fetchCategorie() async{
    final jsonStringCategorie = await rootBundle.loadString('assets/categorie.json');
    final List dataCategorie = json.decode(jsonStringCategorie);
    return dataCategorie.map((e) => TsenaMora.fromCategorie(e)).toList();
  }

  Future <List <TsenaMora>> fetchDescription() async{
    final jsonStringDescription = await rootBundle.loadString('assets/description.json');
    final List dataDescription = json.decode(jsonStringDescription);
    return dataDescription.map((e) => TsenaMora.fromDescription(e)).toList();
  }

}