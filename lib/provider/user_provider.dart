import 'package:flutter/material.dart';
import 'package:my_caliana/model/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isloading = false;

  User? get user => _user;
  bool get isLoading => _isloading;

  void setLoading(bool loading) {
    _isloading = loading;
    notifyListeners();
  }

  void setUser({required User data}) {
    _user = data;
    notifyListeners();
  }
}
