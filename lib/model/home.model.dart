import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  get isVisible => _isVisible;
  bool _isVisible = false;
  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;
  bool isValidUser(String email, String password) {
    if (email == 'admin@gmail.com' && password == 'admin') {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
    return _isValid;
  }
}
