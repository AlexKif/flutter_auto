// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userForms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserForms _$UserFormsFromJson(Map<String, dynamic> json) {
  return UserForms(
    json['content'] as String,
    json['image'] == null
        ? null
        : UserImage.fromJson(json['image'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserFormsToJson(UserForms instance) => <String, dynamic>{
      'content': instance.content,
      'image': instance.image,
    };
