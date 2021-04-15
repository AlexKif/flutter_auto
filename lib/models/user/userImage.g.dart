// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImage _$UserImageFromJson(Map<String, dynamic> json) {
  return UserImage(
    name: json['name'] as String,
    id: json['id'] as int,
    small: json['small'] as String,
    medium: json['medium'] as String,
    original: json['original'] as String,
  );
}

Map<String, dynamic> _$UserImageToJson(UserImage instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'small': instance.small,
      'medium': instance.medium,
      'original': instance.original,
    };
