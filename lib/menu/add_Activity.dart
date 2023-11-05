import 'dart:convert';
import 'package:demo/models/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:demo/Service/service_activity.dart';
import 'package:demo/models/activities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addActivity extends StatefulWidget {
  final Profile? user;
  const addActivity({Key? key, this.user}) : super(key: key);

  @override
  State<addActivity> createState() => _addActivityState();
}

class _addActivityState extends State<addActivity> {
  TextEditingController activityController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late Activities activities;
  late bool isLoading = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    activities = Activities();
    Service_activities.getActivities().then((activitiesFromServer) {
      setState(() {
        isLoading = false;
        activities = activitiesFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Activity'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  addActivity(),
                  list(),
                ],
              ));
  }

  Widget list() {
    return Expanded(
      child: ListView.builder(
        itemCount:
            activities.activities == null ? 0 : activities.activities.length,
        itemBuilder: (BuildContext context, int index) {
          // print('${notes.notes[index].text}');
          return Activity(index);
        },
      ),
    );
  }

  Widget addActivity() {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                          // obscureText: true,
                          controller: activityController,
                          decoration:
                              InputDecoration.collapsed(hintText: "Activity"),
                          style: TextStyle(fontSize: 18))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black)),
                      child: TextField(
                          controller: nameController,
                          // obscureText: true,
                          decoration:
                              InputDecoration.collapsed(hintText: "Name"),
                          style: TextStyle(fontSize: 18))),
                  SizedBox(
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () {
                            add_Activity();
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget Activity(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  leading: Image.network(
                    '${activities.activities[index].img}',
                    height: 30,
                  ),
                  title: Text('${activities.activities[index].name}'))
            ]),
      ),
    );
  }

  Future add_Activity() async {
    var data = {
      "name": nameController.text,
      "img": activityController.text,
    };
    var jsonData = jsonEncode(data);

    var response = await http.post(
        Uri.parse('http://10.160.69.94:8080/api/activity'),
        body: jsonData,
        headers: {
          'Content-Type': 'application/json',
        });

    if (response.statusCode == 201) {
      print('res =' + response.body);
      showToastMessage('add Activity successful');
      nameController.clear();
      activityController.clear();
      Service_activities.getActivities().then((activitiesFromServer) {
        setState(() {
          activities = activitiesFromServer;
        });
      });
    } else {
      print(response.statusCode);
    }
    print("====>" + response.statusCode.toString());
    String result = response.statusCode.toString();
    return result;
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
