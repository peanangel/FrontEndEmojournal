// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Moods _$MoodsFromJson(Map<String, dynamic> json) => Moods()
  ..moods = (json['moods'] as List<dynamic>)
      .map((e) => Mood.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MoodsToJson(Moods instance) => <String, dynamic>{
      'moods': instance.moods,
    };
