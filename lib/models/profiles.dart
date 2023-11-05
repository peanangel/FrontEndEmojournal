import 'package:json_annotation/json_annotation.dart';
import "profile.dart";
part 'profiles.g.dart';

@JsonSerializable()
class Profiles {
  Profiles();

  late List<Profile> profile;
  
  factory Profiles.fromJson(Map<String,dynamic> json) => _$ProfilesFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilesToJson(this);
}
