// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profiles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profiles _$ProfilesFromJson(Map<String, dynamic> json) => Profiles()
  ..profile = (json['profile'] as List<dynamic>)
      .map((e) => Profile.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ProfilesToJson(Profiles instance) => <String, dynamic>{
      'profile': instance.profile,
    };
