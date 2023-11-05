import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/note.dart';
import '/models/notes.dart';

class Service_notes {
  static Future<Notes> getNotes(var userid) async {
    if (userid != null) {
      String url = "http://10.160.69.94:8080/api/notes/$userid/profile";

      try {
        final response = await http.get(Uri.parse(url));
        if (200 == response.statusCode) {
          return parseNotes(response.body);
        } else {
          return Notes();
        }
      } catch (e) {
        print('Error ${e.toString()}');
        return Notes();
      }
    } else {
      String url = "http://10.160.69.94:8080/api/notes/1/profile";
      try {
        final response = await http.get(Uri.parse(url));
        if (200 == response.statusCode) {
          return parseNotes(response.body);
        } else {
          return Notes();
        }
      } catch (e) {
        print('Error ${e.toString()}');
        return Notes();
      }
    }
  }

  static Notes parseNotes(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Note> notes = parsed.map<Note>((json) => Note.fromJson(json)).toList();
    Notes n = Notes();
    n.notes = notes;
    return n;
  }
}
