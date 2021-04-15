import 'package:auto/models/user/userImage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userForms.g.dart';

@JsonSerializable()
class UserForms {
  String content;
  UserImage image;
  UserForms(this.content, this.image);

  factory UserForms.fromJson(Map<String, dynamic> json) =>
      _$UserFormsFromJson(json);
}
