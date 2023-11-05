// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note()
  ..id = json['id'] as num
  ..dateTime = json['dateTime'] as String
  ..text = json['text'] as String
  ..image = json['image'] as String
  ..profile = Profile.fromJson(json['profile'] as Map<String, dynamic>)
  ..mood = Mood.fromJson(json['mood'] as Map<String, dynamic>);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime,
      'text': instance.text,
      'image': instance.image,
      'profile': instance.profile,
      'mood': instance.mood,
    };
