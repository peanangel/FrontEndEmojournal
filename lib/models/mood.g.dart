// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mood _$MoodFromJson(Map<String, dynamic> json) => Mood()
  ..id = json['id'] as num
  ..name = json['name'] as String
  ..img_icon = json['img_icon'] as String;

Map<String, dynamic> _$MoodToJson(Mood instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img_icon': instance.img_icon,
    };
