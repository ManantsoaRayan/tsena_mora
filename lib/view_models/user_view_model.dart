import 'package:flutter/material.dart';
import 'package:tsena_mora/repositories/user_repository.dart';

import '../model/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<User> _users = [];
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  // Register User
  Future<bool> registerUser(String username, password, location, grade) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (await _userRepository.usernameExists(username)) {
        _errorMessage = "Username already taken";
        _isLoading = false;
        notifyListeners();
        return false;
      }

      User newUser = User(
        username: username,
        password: password,
        location: location,
        grade: grade,
        createdAt: DateTime.now().toString(),
      );

      await _userRepository.insertUser(newUser);
      _isLoading = false;
      _currentUser = newUser;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = "Registration failed: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // sign in
  Future<User?> loginUser(String username, password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      User? user = await _userRepository.searchByUsername(username);
      if (user != null && user.password == password) {
        _isLoading = false;
        _currentUser = user;
        notifyListeners();
        return user;
      }
      _isLoading = false;
      _errorMessage = "Username is not registed";
      notifyListeners();
      return null;
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Login failed: ${e.toString()}";
      notifyListeners();
      return null;
    }
  }
}
