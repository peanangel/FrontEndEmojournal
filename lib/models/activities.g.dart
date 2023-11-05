// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activities _$ActivitiesFromJson(Map<String, dynamic> json) => Activities()
  ..activities = (json['activities'] as List<dynamic>)
      .map((e) => Activity.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ActivitiesToJson(Activities instance) =>
    <String, dynamic>{
      'activities': instance.activities,
    };
