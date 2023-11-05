import 'package:json_annotation/json_annotation.dart';
import "note.dart";
import "activity.dart";
part 'activityall.g.dart';

@JsonSerializable()
class Activityall {
  Activityall();

  late num id;
  late Note nid;
  late Activity aid;
  
  factory Activityall.fromJson(Map<String,dynamic> json) => _$ActivityallFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityallToJson(this);
}
