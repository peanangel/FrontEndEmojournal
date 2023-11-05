// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityalls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activityalls _$ActivityallsFromJson(Map<String, dynamic> json) => Activityalls()
  ..activityalls = (json['activityalls'] as List<dynamic>)
      .map((e) => Activityall.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ActivityallsToJson(Activityalls instance) =>
    <String, dynamic>{
      'activityalls': instance.activityalls,
    };
