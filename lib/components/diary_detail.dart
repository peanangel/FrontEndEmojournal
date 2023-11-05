import 'dart:async';
import 'dart:convert';
import 'package:demo/Service/service_activity.dart';
import 'package:demo/models/activityalls.dart';
import 'package:demo/models/index.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Service/service_activityall.dart';
import '../Service/service_note.dart';
import '../Service/service_user.dart';
import '../models/notes.dart';
// import 'editNote.dart';
import 'package:http/http.dart' as http;

class diaryDedail extends StatefulWidget {
  final Profile? user;
  const diaryDedail({Key? key, this.user}) : super(key: key);

  @override
  State<diaryDedail> createState() => _diaryDedailState(user);
}

class _diaryDedailState extends State<diaryDedail> {
  final debouncer = Debouncer(milliseconds: 1000);
  late Notes notes;
  late String title;
  late Activityalls all;
  bool isLoading = false;
  bool isLoadinga = false;
  Profile? profile;

  _diaryDedailState(Profile? user) {
    this.profile = user;
    print("main page=========>>${profile?.email}");
    //  user = Services().getUser(user);
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    title = 'Loading notes ...';
    notes = Notes();
    all = Activityalls();
    Service_notes.getNotes(profile?.id).then((notesFromServer) {
      setState(() {
        notes = notesFromServer;

        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                list()
              ],
            ),
          );
  }

  // Widget searchTF() {
  //   return TextField(
  //     decoration: const InputDecoration(
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(
  //             5.0,
  //           )),
  //         ),
  //         filled: true,
  //         fillColor: Colors.white,
  //         contentPadding: EdgeInsets.all(15.0),
  //         hintText: 'Filter by Mood'),
  //     onChanged: (string) {
  //       debouncer.run(() {
  //         setState(() {
  //           title = 'Searching...';
  //         });
  //         Service_notes.getNotes().then((notesFromServer) {
  //           setState(() {
  //             notes = Notes.filterList(notesFromServer, string);
  //           });
  //         });
  //       });
  //     },
  //   );
  // }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: notes.notes == null ? 0 : notes.notes.length,
        itemBuilder: (BuildContext context, int index) {
          return row(index);
        },
      ),
    );
  }

  Widget row(int index) {
    return Card(
      margin: EdgeInsets.all(15),
      elevation: 15,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${notes.notes[index].mood.img_icon}',
              height: 25,
              width: 25,
            ),
            SizedBox(width: 10),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    
                    width: 450,
                    height: 50,
                    child: ListTile(
                      title: Container(
                          padding: EdgeInsets.only(right: 15),
                         
                          width: 400,
                          child: SizedBox(
                            width: 400,
                            child: Text(
                              '${notes.notes[index].dateTime}',
                              style: TextStyle(fontSize: 15),
                              maxLines: 1,
                            ),
                          )),
                      trailing: Container(
                        
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => {},
                                icon: Icon(
                                  Icons.arrow_circle_right_outlined,
                                  size: 22,
                                )),
                            IconButton(
                                onPressed: () =>
                                    {deleteNote(notes.notes[index].id)},
                                icon: Icon(
                                  Icons.delete,
                                  size: 22,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Row(
                  //   // ignore: unnecessary_null_comparison
                  //   children: [

                  //     listActivityAll(notes.notes[index].id)
                  //     ],
                  // ),
                  SizedBox(height: 10),
                  Text(
                    "${notes.notes[index].text}",
                    style: TextStyle(fontSize: 16),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          child: notes.notes[index].image == "None"
                              ? Text("Do not have image")
                              : showImage(notes.notes[index].image),
                          height: 100,
                          width: 150,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  Future deleteNote(var id) async {
    print('delete $id');
    final String url = 'http://10.160.69.94:8080/api/notes/$id';

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 202) {
      print('Delete request was successful');
      Service_notes.getNotes(profile?.id).then((notesFromServer) {
        setState(() {
          notes = notesFromServer;

          isLoading = false;
        });
      });
      showToastMessage('Deleted');
    } else {
      print('Delete request failed with status: ${response.statusCode}');
    }
  }

  Activityalls getAllAcByNoteId(var nid) {
    late Activityalls acAlls = Activityalls();
    isLoadinga = true;
    Service_activityAll.getActivityAllByNoteId(nid).then((acAllFromServer) {
      setState(() {
        acAlls = acAllFromServer;
        isLoadinga = false;
      });
    });

    return acAlls;
  }

  Widget listActivityAll(var nid) {
    late Activityalls acAlls = getAllAcByNoteId(nid);
    return Expanded(
      child: acAlls == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: List.generate(acAlls.activityalls.length,
                  (index) => rowOfActivity(index, acAlls)),
            ),
      // child: ListView.builder(
      //   // ignore: unnecessary_null_comparison
      //   itemCount: acAlls.activityalls == null ? 0 : acAlls.activityalls.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return rowOfActivity(index);
      //   },
      // ),
    );
  }

  Widget rowOfActivity(int index, Activityalls acAlls) {
    return isLoadinga
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: Column(
              children: [
                Image.network(acAlls.activityalls[index].aid.img),
                Text('${acAlls.activityalls[index].aid.name}')
              ],
            ),
          );
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds), action);
  }
}
