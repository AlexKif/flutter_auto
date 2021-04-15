import 'package:auto/models/user/user.dart';
import 'package:auto/models/user/userForms.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  User _userData;
  UserForms _userForms;

  void setUserData(User user) {
    this._userData = user;
    notifyListeners();
  }

  User getUserData() {
    return _userData;
  }
}
