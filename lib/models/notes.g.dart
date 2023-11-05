// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notes _$NotesFromJson(Map<String, dynamic> json) => Notes()
  ..notes = (json['notes'] as List<dynamic>)
      .map((e) => Note.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'notes': instance.notes,
    };
