import 'dart:convert';
import 'package:demo/models/activities.dart';
import 'package:demo/models/activityall.dart';
import 'package:demo/models/activityalls.dart';
import 'package:http/http.dart' as http;

import '../models/activity.dart';

class Service_activityAll {
  static const String url = "http://10.160.69.94:8080/api/activityall";

  static Future<Activityalls> getActivityAll() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return parseActivity(response.body);
      } else {
        return Activityalls();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Activityalls();
    }
  }

  static Activityalls parseActivity(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Activityall> activities =
        parsed.map<Activityall>((json) => Activityall.fromJson(json)).toList();
    Activityalls p = Activityalls();
    p.activityalls = activities;
    return p;
  }

  static Future<Activityalls> getActivityAllByNoteId(var nid) async {
    try {
      final response = await http
          .get(Uri.parse("http://10.160.69.94:8080/api/activityall/$nid/note"));
      if (200 == response.statusCode) {
        print(response.body);
        return parseActivity(response.body);
      } else {
        return Activityalls();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Activityalls();
    }
  }
}
