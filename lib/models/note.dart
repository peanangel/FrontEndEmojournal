import 'package:json_annotation/json_annotation.dart';
import "profile.dart";
import "mood.dart";
part 'note.g.dart';

@JsonSerializable()
class Note {
  Note();

  late num id;
  late String dateTime;
  late String text;
  late String image;
  late Profile profile;
  late Mood mood;
  
  factory Note.fromJson(Map<String,dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
