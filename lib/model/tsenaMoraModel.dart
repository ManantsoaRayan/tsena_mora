class TsenaMora{
  String userName;
  String password;

  TsenaMora({
    this.userName = '',
    this.password = '',
  });
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
}