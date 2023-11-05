import 'package:json_annotation/json_annotation.dart';
import "note.dart";
part 'notes.g.dart';

@JsonSerializable()
class Notes {
  Notes();

  late List<Note> notes;
  
  factory Notes.fromJson(Map<String,dynamic> json) => _$NotesFromJson(json);
  Map<String, dynamic> toJson() => _$NotesToJson(this);
}
