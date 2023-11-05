// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activityall _$ActivityallFromJson(Map<String, dynamic> json) => Activityall()
  ..id = json['id'] as num
  ..nid = Note.fromJson(json['nid'] as Map<String, dynamic>)
  ..aid = Activity.fromJson(json['aid'] as Map<String, dynamic>);

Map<String, dynamic> _$ActivityallToJson(Activityall instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nid': instance.nid,
      'aid': instance.aid,
    };
