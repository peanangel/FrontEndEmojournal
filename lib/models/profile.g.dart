// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..id = json['id'] as num
  ..userName = json['userName'] as String
  ..email = json['email'] as String
  ..password = json['password'] as String
  ..img = json['img'] as String;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'img': instance.img,
    };
