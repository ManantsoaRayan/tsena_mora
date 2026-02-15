import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _location = "Unknown";
  
  String get location => _location;

  void setLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }
}
