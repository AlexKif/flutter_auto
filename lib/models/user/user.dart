import 'package:auto/models/user/userForms.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String phone;
  String token;
  User(this.phone, this.token);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
