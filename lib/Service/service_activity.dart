import 'dart:convert';
import 'package:demo/models/activities.dart';
import 'package:http/http.dart' as http;

import '../models/activity.dart';

class Service_activities {
  static const String url = "http://10.160.69.94:8080/api/activities";

  static Future<Activities> getActivities() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseUsers(response.body);
      } else {
        return Activities();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Activities();
    }
  }

  static Activities parseUsers(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Activity> activities =
        parsed.map<Activity>((json) => Activity.fromJson(json)).toList();
    Activities p = Activities();
    p.activities = activities;
    return p;
  }
}
