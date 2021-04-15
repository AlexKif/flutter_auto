import 'package:json_annotation/json_annotation.dart';

class SignInModel {
  final String token;
  final String phone;

  SignInModel({this.token, this.phone});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(token: json['token'], phone: json['phone']);
  }
}

class SignUpModel {
  final String token;
  final String phone;

  SignUpModel({this.token, this.phone});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(token: json['token'], phone: json['phone']);
  }
}

class LogoutModel {
  final String message;
  LogoutModel(this.message);
}
