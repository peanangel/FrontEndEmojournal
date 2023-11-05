import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/profile.dart';
import '/models/profiles.dart';

class Services {
  static const String url = "http://10.160.69.94:8080/api/profiles";

  static Future<Profiles> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseUsers(response.body);
      } else {
        return Profiles();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Profiles();
    }
  }

  static Profiles parseUsers(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Profile> profiles =
        parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
    Profiles p = Profiles();
    p.profile = profiles;
    return p;
  }

  static Profile parseUser(String reponseBody) {
    final parsed = json.decode(reponseBody);
    Profile profile = parsed.map<Profile>((json) => Profile.fromJson(json));
    Profile p = Profile();
    p = profile;
    return p;
  }

  Future getEmail(var email) async {
    const String url = "http://10.160.69.94:8080/api/profiles";
    try {
      final res = await http.get(Uri.parse(url));
      if (200 == res.statusCode) {
        return parseUsers(res.body);
      } else {
        return Profiles();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Profiles();
    }
  }

  getUser(var user) async {
    Profile? profile;

    String url = "http://10.160.69.94:8080/api/profile/${user?.id.toString()}";
    try {
      final res = await http.get(Uri.parse(url));
      if (200 == res.statusCode) {
        // profile = Services.parseUser(res.body);
        print(res.body);
        final parsed = json.decode(res.body);
        // profile = jsonDecode(res.body);
        profile = Profile.fromJson(parsed);
        print("============>${profile.email}");

        return profile;
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
    return profile;
  }
}
