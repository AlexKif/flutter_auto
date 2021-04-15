import 'package:flutter/material.dart';

class SignViewModel extends ChangeNotifier {
  String phoneNumber;
  String password;

  void setPhoneNumber(number) {
    phoneNumber = number;
    notifyListeners();
  }

  void setPassword(password) {
    password = password;
    notifyListeners();
  }
}
