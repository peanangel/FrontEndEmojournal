// import 'dart:convert';
// import 'dart:io';

// import 'package:demo/Service/service_activity.dart';
// import 'package:demo/Service/service_mood.dart';
// import 'package:demo/main.dart';
// import 'package:demo/models/activities.dart';
// import 'package:demo/models/index.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// // import 'package:toast/toast.dart';
// import '../menu/item.dart';
// import '../models/activity.dart';
// import '../models/mood.dart';
// import '../models/moods.dart';

// class editNotePage extends StatefulWidget {
//   int index;
//   editNotePage( {Key? key,required this.index}): super(key: key);

  
//   @override
//   State<editNotePage> createState() => _editNotePageState();
// }

// class _editNotePageState extends State<editNotePage> {
//   late Moods moods;
//   late String title;
//   late Activities activities;
//   late DateTime datetime;
//   var time = DateTime.now();
//   Mood mood = Mood();
//   bool isLoading = false;
//   bool isLoading_ac = false;
//   TextEditingController noteController = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   late final ValueChanged<bool> onSelected;
//   bool _isSelected = false;
//   late File imageFile;
//   String? imgData;

//   static const String url = "http://172.16.1.9:8080/api/notes";

//   choiceImage() async {
//     final ImagePicker picker = ImagePicker();
//     var pickedImage = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         imageFile = File(pickedImage.path);
//       });
//       imgData = base64Encode(imageFile.readAsBytesSync());
//       return imgData;
//     } else {
//       return null;
//     }
//   }

//   takeAPicture() async {
//     final ImagePicker picker = ImagePicker();
//     var pickedImage = await picker.pickImage(source: ImageSource.camera);
//     if (pickedImage != null) {
//       setState(() {
//         imageFile = File(pickedImage.path);
//       });
//       imgData = base64Encode(imageFile.readAsBytesSync());
//       return imgData;
//     } else {
//       return null;
//     }
//   }

//   showImage(String image) {
//     return Image.memory(base64Decode(image));
//   }

  

//   @override
//   void initState() {
//     super.initState();
//     isLoading = true;
//     isLoading_ac = true;
//     moods = Moods();
//     activities = Activities();
//     title = "Loading...";
//     Service_mood.getMoods().then((moodsFromServer) {
//       setState(() {
//         moods = moodsFromServer;
//         isLoading = false;
//       });
//     });
//     Service_activities.getActivities().then((activitiesFromServer) {
//       setState(() {
//         activities = activitiesFromServer;
//         isLoading_ac = false;
//       });
//     });
//   }

//   List<Activity> pickItems = [];
//   List<bool> toggleValues = [false, false, false, false, false];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Add'),
//         ),
//         body: Container(
//             padding: const EdgeInsets.all(10.0),
//             child: isLoading
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 '${DateFormat.yMMMEd().format(time)}',
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text('${DateFormat.jm().format(time)}'),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   showCupertinoModalPopup(
//                                       context: context,
//                                       builder: (context) {
//                                         return Container(
//                                           height: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.4,
//                                           color: Colors.white,
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               TextButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text('Done')),
//                                               Expanded(
//                                                   child: CupertinoDatePicker(
//                                                       initialDateTime: time,
//                                                       mode:
//                                                           CupertinoDatePickerMode
//                                                               .dateAndTime,
//                                                       minimumDate:
//                                                           DateTime(2000),
//                                                       maximumDate:
//                                                           DateTime.now(),
//                                                       use24hFormat: true,
//                                                       onDateTimeChanged:
//                                                           (date) {
//                                                         setState(() {
//                                                           time = date;
//                                                         });
//                                                       }))
//                                             ],
//                                           ),
//                                         );
//                                       });
//                                 },
//                                 child: Icon(Icons.create_outlined),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Mood'),
//                           Column(
//                             children: [
//                               Card(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ToggleButtons(
//                                       children: [
//                                         selectMood(0),
//                                         selectMood(1),
//                                         selectMood(2),
//                                         selectMood(3),
//                                         selectMood(4),
//                                       ],
//                                       onPressed: (index) {
//                                         setState(() {
//                                           for (int i = 0;
//                                               i < toggleValues.length;
//                                               i++) {
//                                             toggleValues[i] = i == index;
//                                           }
//                                           mood = moods.moods[index];
//                                         });
//                                       },
//                                       isSelected: toggleValues,
//                                     )
//                                   ],
//                                 ),
//                               )
//                               // )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Note'),
//                           TextField(
//                             controller: noteController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: null,
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 hintText: 'How do you do?'),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('Activites'),
//                           Container(
//                             padding: EdgeInsets.all(8),
//                             height: 150,
//                             child: Expanded(
//                               child: isLoading
//                                   ? Center(
//                                       child: CircularProgressIndicator(),
//                                     )
//                                   : ListView(
//                                       scrollDirection: Axis.horizontal,
//                                       children: [
//                                         ...List.generate(
//                                             activities.activities.length,
//                                             (index) => Item(
//                                                   activity: activities
//                                                       .activities[index],
//                                                   onSelected: (bool value) {
//                                                     if (value) {
//                                                       pickItems.add(activities
//                                                           .activities[index]);
//                                                     } else {
//                                                       pickItems.remove(
//                                                           activities.activities[
//                                                               index]);
//                                                     }

//                                                     setState(() {});
//                                                   },
//                                                 ))
//                                       ],
//                                     ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 6,
//                           ),
//                           Center(
//                             child: Card(
//                               elevation: 0,
//                               color:
//                                   Theme.of(context).colorScheme.surfaceVariant,
//                               child: SizedBox(
//                                 // width: 300,
//                                 // height: 100,
//                                 child: imgData == null
//                                     ? Center(
//                                         child: Text('no image'),
//                                       )
//                                     : Center(
//                                         child: Container(
//                                           child: showImage(imgData!),
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   takeAPicture();
//                                 },
//                                 child: const Text('Take a Photo'),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               ElevatedButton(
//                                 onPressed: () async {
//                                   choiceImage();
//                                 },
//                                 child: const Text('Select Image'),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               SizedBox(
//                                 width: 280,
//                                 child: ElevatedButton(
//                                   onPressed: () async {
//                                     var m;
//                                     if (noteController.text.isEmpty ||
//                                         mood.id == null ||
//                                         pickItems.length == 0) {
//                                       showToastMessage('can not save');
//                                     } else {
//                                       // m = await addNote();
//                                       print("------------>" + m.toString());
//                                       if (m == '201') {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (context) => MyApp()));
//                                       } else {
//                                         showToastMessage('can not save');
//                                       }
//                                     }
//                                   },
//                                   child: const Text(
//                                     'Save',
//                                     style: TextStyle(fontSize: 15),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   )));
//   }

//   Widget selectMood(int index) {
//     return Image.network(
//       '${moods.moods[index].img_icon}',
//       height: 50,
//       width: 60,
//     );
//   }

//   void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
// }
