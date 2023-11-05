import 'dart:convert';
import 'dart:io';
import 'package:demo/Service/service_activity.dart';
import 'package:demo/Service/service_mood.dart';
import 'package:demo/main.dart';
import 'package:demo/models/activities.dart';
import 'package:demo/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:toast/toast.dart';
import '../models/activity.dart';
import '../models/mood.dart';
import '../models/moods.dart';
import 'item.dart';

class addPage extends StatefulWidget {
  final Profile? user;
  const addPage({Key? key, this.user}) : super(key: key);

  @override
  State<addPage> createState() => _addPageState(user);
}

class _addPageState extends State<addPage> {
  late Moods moods;
  late String title;
  late Activities activities;
  late DateTime datetime;
  var time = DateTime.now();
  Mood mood = Mood();
  bool isLoading = false;
  bool isLoading_ac = false;
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late final ValueChanged<bool> onSelected;
  bool _isSelected = false;
  late File imageFile;
  String? imgData= "None";
  Profile? profile;
  static const String url = "http://10.160.69.94:8080/api/notes";

  _addPageState(Profile? user){
    this.profile = user;
    print("add_page profile ==${profile?.email}");
  }
  

  choiceImage() async {
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      imgData = base64Encode(imageFile.readAsBytesSync());
      return imgData;
    } else {
      return null;
    }
  }

  takeAPicture() async {
    final ImagePicker picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      imgData = base64Encode(imageFile.readAsBytesSync());
      return imgData;
    } else {
      return null;
    }
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  Future addNote() async {
    String formattedDateTimeString = time.toLocal().toIso8601String();
    print("add_page profile ==${profile?.id}");
    var data = {
      "dateTime": formattedDateTimeString,
      "image": imgData,
      "text": noteController.text,
      "profile": {"id": profile?.id},
      "mood": {"id": mood.id}
    };
    var jsonData = jsonEncode(data);

    var response = await http.post(Uri.parse(url), body: jsonData, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      print('res =' + response.body);
    } else {
      for (var index = 0; index < pickItems.length; index++) {
        var data = {
          "activity": {"id": pickItems[index].id},
          "note": {"id": response.body}
        };
        try {
          final response = await http.post(
            Uri.parse('http://10.160.69.94:8080/api/activityall'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          );

          if (response.statusCode == 200) {
            print('Success: ${response.body}');
          } else {
            print('Error: ${response.statusCode}');
          }
        } catch (e) {
          print('Exception: $e');
        }
      }
      print(response.body);
    }
    print("====>" + response.statusCode.toString());
    String result = response.statusCode.toString();
    return result;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    isLoading_ac = true;
    moods = Moods();
    activities = Activities();
    title = "Loading...";
    Service_mood.getMoods().then((moodsFromServer) {
      setState(() {
        moods = moodsFromServer;
        isLoading = false;
      });
    });
    Service_activities.getActivities().then((activitiesFromServer) {
      setState(() {
        activities = activitiesFromServer;
        isLoading_ac = false;
      });
    });
  }

  List<Activity> pickItems = [];
  List<bool> toggleValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add'),
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${DateFormat.yMMMEd().format(time)}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('${DateFormat.jm().format(time)}'),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Done')),
                                              Expanded(
                                                  child: CupertinoDatePicker(
                                                      initialDateTime: time,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .dateAndTime,
                                                      minimumDate:
                                                          DateTime(2000),
                                                      maximumDate:
                                                          DateTime.now(),
                                                      use24hFormat: true,
                                                      onDateTimeChanged:
                                                          (date) {
                                                        setState(() {
                                                          time = date;
                                                        });
                                                      }))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Icon(Icons.create_outlined),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Mood'),
                          Column(
                            children: [
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ToggleButtons(
                                      children: [
                                        selectMood(0),
                                        selectMood(1),
                                        selectMood(2),
                                        selectMood(3),
                                        selectMood(4),
                                      ],
                                      onPressed: (index) {
                                        setState(() {
                                          for (int i = 0;
                                              i < toggleValues.length;
                                              i++) {
                                            toggleValues[i] = i == index;
                                          }
                                          mood = moods.moods[index];
                                        });
                                      },
                                      isSelected: toggleValues,
                                    )
                                  ],
                                ),
                              )
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Note'),
                          TextField(
                            controller: noteController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'How do you do?'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Activites'),
                          Container(
                            padding: EdgeInsets.all(8),
                            height: 150,
                            child: Expanded(
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ...List.generate(
                                            activities.activities.length,
                                            (index) => Item(
                                                  activity: activities
                                                      .activities[index],
                                                  onSelected: (bool value) {
                                                    if (value) {
                                                      pickItems.add(activities
                                                          .activities[index]);
                                                    } else {
                                                      pickItems.remove(
                                                          activities.activities[
                                                              index]);
                                                    }

                                                    setState(() {});
                                                  },
                                                ))
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: Card(
                              elevation: 0,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              child: SizedBox(
                                // width: 300,
                                // height: 100,
                                child: imgData == "None"
                                    ? Center(
                                        child: Text('no image'),
                                      )
                                    : Center(
                                        child: Container(
                                          child: showImage(imgData!),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  takeAPicture();
                                },
                                child: const Text('Take a Photo'),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  choiceImage();
                                },
                                child: const Text('Select Image'),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 280,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var m;
                                    if (noteController.text.isEmpty ||
                                        mood.id == null ||
                                        pickItems.length == 0) {
                                      showToastMessage('can not save');
                                    } else {
                                      m = await addNote();
                                      print("------------>" + m.toString());
                                      if (m == '201') {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => MyHomePage(user: profile,)));
                                      } else {
                                        showToastMessage('can not save');
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )));
  }

  Widget selectMood(int index) {
    return Image.network(
      '${moods.moods[index].img_icon}',
      height: 50,
      width: 60,
    );
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
