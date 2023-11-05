import 'dart:convert';
import 'package:demo/Service/service_user.dart' as serviceuser;
import 'package:demo/menu/profile_page.dart';
import 'package:demo/models/index.dart';
import 'package:demo/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../toHex.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class editProfilePage extends StatefulWidget {
  final Profile? user;
  const editProfilePage({Key? key, this.user}) : super(key: key);
  @override
  State<editProfilePage> createState() => _editProfilePageState(user);
}

class _editProfilePageState extends State<editProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Profile? user;
  var id = '1';
  late File imageFile;
  late String? imgData = user?.img;

  _editProfilePageState(Profile? user) {
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: HexColor("FFF1E9"),
          appBar: AppBar(
            backgroundColor: HexColor("FFF1E9"),
            title: Text("Edit Profile"),
          ),
          body: ListView(
            children: [
              Column(
                children: <Widget>[Profiles()],
              ),
            ],
          )),
    );
  }

  choiceImage() async {
    late ImagePicker picker = ImagePicker();
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

  Widget Profiles() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(children: <Widget>[
        Center(
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Container(
              child: user?.img == "none"
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://pixlok.com/wp-content/uploads/2022/02/Profile-Icon-SVG-09856789.png'),
                    )
                  : CircleAvatar(
                      // Set the background color of the CircleAvatar
                      radius: 50, // Adjust the radius as needed
                      child: ClipOval(
                        child: Image.memory(
                          base64Decode(imgData!),
                          width: 100, // Adjust the width and height as needed
                          height: 100,
                        ),
                      ),
                    )),
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
        SizedBox(height: 10),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: user?.userName,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ]),
          ),
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: user?.email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  )
                ]),
          ),
        ),
        SizedBox(
          width: 200,
          height: 80,
          child: ElevatedButton(
            onPressed: () async {
              print("+con" + emailController.text);

              showToastMessage('can not save jaa');

              var m = await editProfile();
              print("------------>" + m.toString());

              if (m == '200') {
                showToastMessage('Profile update');

                user = serviceuser.Services().getUser(user);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => profilePage(
                          user: user,
                        )));
              } else {
                showToastMessage('can not save');
              }
            },
            child: Text('Done'),
          ),
        ),
      ]),
    );
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  Future editProfile() async {
    // if (user?.id != null) {
    id = user!.id.toString();

    var url = 'http://10.160.69.94:8080/api/profile/$id';
    var data = {
      "userName": nameController.text,
      "email": emailController.text,
      "password": user?.password,
      "img": imgData
    };
    var jsonData = jsonEncode(data);
    var response = await http.put(Uri.parse(url), body: jsonData, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('res =' + response.body);
    } else {
      print("================>" + response.body);
    }
    print("====>" + response.statusCode.toString());
    String result = response.statusCode.toString();
    return result;
    // } else {
    //   return "null";
    // }
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

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
}
