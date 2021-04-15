import 'package:json_annotation/json_annotation.dart';

part 'userImage.g.dart';

@JsonSerializable()
class UserImage {
  int id;
  String name;
  String small;
  String medium;
  String original;
  UserImage({this.name, this.id, this.small, this.medium, this.original});

  factory UserImage.fromJson(Map<String, dynamic> json) =>
      _$UserImageFromJson(json);
}
