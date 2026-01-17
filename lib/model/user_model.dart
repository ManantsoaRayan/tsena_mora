class TsenaMora {
  String userName;
  String password;

  TsenaMora({this.userName = '', this.password = ''});
}

class TsenaMoraModel {
  List<TsenaMora> userList = [
    TsenaMora(userName: 'Alice', password: "1234"),
    TsenaMora(userName: "Toky", password: "12345678"),
  ];

  List<TsenaMora> get getUserList => List.unmodifiable(userList);

  void addUser(String user, String password) {
    userList.add(TsenaMora(userName: user, password: password));
  }

  bool authenticateUser(String userName, String password) {
    try {
      final userFound = userList.firstWhere((user) => user.userName == userName);
      return userFound.password == password;
    } catch (e) {
      return false;
    }

  }
}
