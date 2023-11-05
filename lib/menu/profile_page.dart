import 'dart:convert';

import 'package:demo/components/NavBar.dart';
import 'package:demo/main.dart';
import 'package:demo/menu/edit_profile.dart';
import 'package:demo/menu/signin_page.dart';
import 'package:demo/models/index.dart';
import 'package:demo/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/profile.dart';

import '../toHex.dart';

class profilePage extends StatefulWidget {
  final Profile? user;
  const profilePage({Key? key, this.user}) : super(key: key);
  @override
  State<profilePage> createState() => _profilePageState(user);
}

class _profilePageState extends State<profilePage> {
  Profile? user;
  _profilePageState(Profile? user) {
    this.user = user;
  }
  @override
  void initState() {
    super.initState();
    NavBar(
      user: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          // drawer: NavDrawer(),
          backgroundColor: HexColor("FFF1E9"),
          appBar: AppBar(
            backgroundColor: HexColor("FFF1E9"),
            title: Text("Profile"),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              user = null;
              print("user profile logout button ${user?.email}");
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
            },
            label: Text('Logout'),
            icon: Icon(Icons.logout_outlined),
            backgroundColor: HexColor("FC7FB2"),
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
                :CircleAvatar(
                      backgroundColor: Colors
                          .blue, // Set the background color of the CircleAvatar
                      radius: 50, // Adjust the radius as needed
                      child: ClipOval(
                        child: Image.memory(
                          base64Decode(user!.img),
                          width: 100, // Adjust the width and height as needed
                          height: 100,
                        ),
                      ),
                    )
          ),
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
                  ListTile(
                    title: Text("Name",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black)),
                    subtitle: Text("${user?.userName}",
                        style: const TextStyle(
                          fontSize: 18,
                        )),
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
                  ListTile(
                    title: Text("Email",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black)),
                    subtitle: Text("${user?.email}",
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                  )
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 200,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => editProfilePage(
                        user: user,
                      )));
            },
            child: Text('Edit Profile'),
          ),
        ),
      ]),
    );
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }
}
