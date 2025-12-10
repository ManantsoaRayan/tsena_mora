import 'package:flutter/material.dart';
import 'package:tsena_mora/model/tsenaMoraModel.dart';

class TsenaMoraViewModel extends ChangeNotifier {

  final TsenaMoraModel tsenaModel = TsenaMoraModel();

  List<TsenaMora> get userList => tsenaModel.getUserList;
  List<TsenaMora> get passwordList => tsenaModel.getPasswordList;

  void addUser(String user) {
    tsenaModel.addUser(user);
    notifyListeners();
  }

  void addPassword(String password) {
    tsenaModel.addPassword(password);
    notifyListeners();
  }

  bool authenticateUser(String userName) {
    return tsenaModel.authenticateUser(userName);
  }

  bool authenticatePassword(String password) {
    return tsenaModel.authenticatePassword(password);
  }
}