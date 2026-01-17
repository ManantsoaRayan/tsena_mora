import 'package:flutter/material.dart';
import 'package:tsena_mora/model/user_model.dart';

class TsenaMoraViewModel extends ChangeNotifier {

  final TsenaMoraModel tsenaModel = TsenaMoraModel();

  List<TsenaMora> get userList => tsenaModel.getUserList;

  void addUser(String user  , String password) {
    tsenaModel.addUser(user, password);
    notifyListeners();
  }

  bool authenticateUser(String userName, String password) {
    return tsenaModel.authenticateUser(userName, password);
  }
}