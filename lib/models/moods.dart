import 'package:json_annotation/json_annotation.dart';
import "mood.dart";
part 'moods.g.dart';

@JsonSerializable()
class Moods {
  Moods();

  late List<Mood> moods;
  
  factory Moods.fromJson(Map<String,dynamic> json) => _$MoodsFromJson(json);
  Map<String, dynamic> toJson() => _$MoodsToJson(this);
}
