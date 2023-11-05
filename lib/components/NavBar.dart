import 'package:demo/menu/add_Activity.dart';
import 'package:demo/models/index.dart';
import 'package:demo/toHex.dart';
import 'package:flutter/material.dart';
import 'package:demo/menu/add_page.dart';
import 'package:demo/menu/calendar_page.dart';
import 'package:demo/menu/profile_page.dart';

import '../Service/service_user.dart';

class NavBar extends StatefulWidget {
  final Profile? user;
  const NavBar({Key? key, this.user}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState(user);
}

class _NavBarState extends State<NavBar> {
  bool light0 = true;
  bool light1 = true;
  Profile? user;
  _NavBarState(Profile? user) {
    this.user = user;
    // user = Services().getUser(user);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor('#45454D'),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
                child: Text(
              "EmoJournal",
              style: TextStyle(color: Colors.white),
            )),
          ),
          // Divider(),
          ListTile(
            leading:
                Icon(Icons.add_circle_outline_outlined, color: Colors.white),
            title: Text('Add', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => addPage(user: user,))),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_month, color: Colors.white),
            title: Text('Calendar', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => calendarPage(user: user,))),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.assignment_add, color: Colors.white),
            title: Text('Activity', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => addActivity(user: user,))),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.white),
            title: Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => profilePage(user: user,))),
          ),

          Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            title: Text('Notification', style: TextStyle(color: Colors.white)),
            onTap: () => null,
            trailing: Container(
              decoration: BoxDecoration(),
              child: Switch(
                value: light0,
                onChanged: (bool value) {
                  setState(() {
                    light0 = value;
                  });
                },
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
