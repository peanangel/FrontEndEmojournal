import 'package:json_annotation/json_annotation.dart';
import "activityall.dart";
part 'activityalls.g.dart';

@JsonSerializable()
class Activityalls {
  Activityalls();

  late List<Activityall> activityalls;
  
  factory Activityalls.fromJson(Map<String,dynamic> json) => _$ActivityallsFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityallsToJson(this);
}
