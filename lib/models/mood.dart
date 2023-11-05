import 'package:json_annotation/json_annotation.dart';

part 'mood.g.dart';

@JsonSerializable()
class Mood {
  Mood();

  late num id;
  late String name;
  late String img_icon;
  
  factory Mood.fromJson(Map<String,dynamic> json) => _$MoodFromJson(json);
  Map<String, dynamic> toJson() => _$MoodToJson(this);
}
