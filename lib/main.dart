import 'package:demo/components/goToLogin.dart';
import 'package:demo/models/index.dart';
import 'package:demo/toHex.dart';
import 'package:flutter/material.dart';
import 'components/NavBar.dart';
import 'components/diary_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Profile? user;
  const MyHomePage({Key? key, this.user}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<MyHomePage> {
  Profile? profile;

  _MyHomePageState(Profile? user) {
    this.profile = user;
    print("main page=========>>${profile?.email}");
  }

  @override
  Widget build(BuildContext context) {
    return profile == null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor('#45454D'),
              title: Text(
                'EmoJournal',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: goToLoginPage())
        : Scaffold(
            drawer: NavBar(
              user: profile,
            ),
            appBar: AppBar(
              backgroundColor: HexColor('#45454D'),
              title: Text(
                'EmoJournal',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: diaryDedail(
              user: profile,
            ),
          );
  }
}
