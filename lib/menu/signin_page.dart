import 'dart:convert';
import 'dart:math';
import 'package:crypt/crypt.dart';
import 'package:demo/main.dart';
import 'package:demo/menu/changePwd_page.dart';
import 'package:demo/menu/signUp_page.dart';
import 'package:demo/models/index.dart';
import 'package:demo/toHex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:demo/Service/service_user.dart';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class signInPage extends StatefulWidget {
  const signInPage({super.key});

  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("FFF1E9"),
        body: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
                child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.all(40),
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                        SizedBox(
                          height: 20,
                        ),
                        const Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/2602/2602410.png?ga=GA1.1.1317775886.1691651465'),
                          height: 120,
                          width: 120,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Emojournal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldEmail(),
                        TextFieldPassword(),
                        ButtonSignIn(context),
                        buildButtonSignUp(context),
                        //buildForgotPassword(context),
                      ],
                    )),
              ],
            ))));
  }

  Container TextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container TextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration.collapsed(hintText: "Password"),
          style: TextStyle(fontSize: 18),
        ));
  }

  InkWell buildButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: HexColor("FC7FB2"),
                border: Border.all(color: Colors.black)),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => navigateToMyRegister(context));
  }

  buildForgotPassword(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Forgot password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black),
                color: HexColor("FC7FB2")),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => navigateToMyResetPasswordPage(context));
  }

  navigateToMyResetPasswordPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyResetPasswordPage()));
  }

  navigateToMyRegister(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Register()));
  }

  InkWell ButtonSignIn(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("LogIn",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: HexColor("FC7FB2"),
                border: Border.all(color: Colors.black)),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () {
          login();
        });
  }

  // navigateToMain(BuildContext context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  // }

  login() async {
    Profile profile;
    var email = emailController.text;
    var pwd = passwordController.text;
    String url = "http://10.160.69.94:8080/api/login/$email";
    try {
      final res = await http.get(Uri.parse(url));
      if (200 == res.statusCode) {
        // profile = Services.parseUser(res.body);
        print(res.body);
        final parsed = json.decode(res.body);
        // profile = jsonDecode(res.body);
        profile = Profile.fromJson(parsed);
        // final hpwd = Crypt.sha256(pwd);
        final bytes = utf8.encode(pwd); // Encode the password as bytes
        final hpwd = sha256.convert(bytes);
        print(hpwd.toString());
        if (profile.password == hpwd.toString()) {
          print('pwd-match: ${profile.password}');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyHomePage(user:profile)));
        } else {
          print("not correct");
        }
        print("============>${profile.email}");
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
