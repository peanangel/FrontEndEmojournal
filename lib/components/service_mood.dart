import 'dart:convert';
import 'package:demo/models/mood.dart';
import 'package:demo/models/moods.dart';
import 'package:http/http.dart' as http;

class Service_mood {
  static const String url = "http://10.160.69.94:8080/api/moods";

  static Future<Moods> getMoods() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseUsers(response.body);
      } else {
        return Moods();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Moods();
    }
  }

  static Moods parseUsers(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Mood> moods = parsed.map<Mood>((json) => Mood.fromJson(json)).toList();
    Moods p = Moods();
    p.moods = moods;
    return p;
  }
}
