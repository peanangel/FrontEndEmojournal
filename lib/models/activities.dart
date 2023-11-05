import 'package:json_annotation/json_annotation.dart';
import "activity.dart";
part 'activities.g.dart';

@JsonSerializable()
class Activities {
  Activities();

  late List<Activity> activities;
  
  factory Activities.fromJson(Map<String,dynamic> json) => _$ActivitiesFromJson(json);
  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);
}
