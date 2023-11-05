import 'dart:convert';
import 'package:crypt/crypt.dart';
import 'package:demo/menu/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../toHex.dart';
import 'package:crypto/crypto.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdcmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#FFF1E9'),
        ),
        body: Container(
            padding: EdgeInsets.zero,
            color: HexColor("FFF1E9"),
            child: Center(
                child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Register",
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
                        buildTextFielName(),
                        buildTextFieldEmail(),
                        buildTextFieldPassword(),
                        buildTextFieldPasswordConfirm(),
                        buildButtonRegister(context),
                      ],
                    )),
              ],
            ))));
  }

  InkWell buildButtonRegister(BuildContext context) {
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
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () async {
          if (nameController.text.isEmpty ||
              emailController.text.isEmpty ||
              pwdController.text.isEmpty ||
              pwdcmController.text.isEmpty) {
            showToastMessage("cant register");
          } else {
            if (pwdController.text == pwdcmController.text) {
              var m = await registerUser();
              print("------------>" + m.toString());
              if (m == '201') {
                showToastMessage('pwd chk');
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => signInPage()));
              } else {
                showToastMessage('can not save');
              }
            } else {
              showToastMessage('pwd not match');
            }
          }
        });
  }

  navigateToMyLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const signInPage()));
  }

  Container buildTextFielName() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
            controller: nameController,
            decoration: InputDecoration.collapsed(hintText: "Name"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
            controller: pwdController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPasswordConfirm() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black)),
        child: TextField(
            controller: pwdcmController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Confirm Password"),
            style: TextStyle(fontSize: 18)));
  }

  void showToastMessage(String message) => Fluttertoast.showToast(msg: message);
  Future registerUser() async {
    String pwd = pwdController.text;
    // final hpwd = Crypt.sha256(pwd);
    final bytes = utf8.encode(pwd); // Encode the password as bytes
    final hpwd = sha256.convert(bytes);

    const url = 'http://10.160.69.94:8080/api/profile';
    var data = {
      "userName": nameController.text,
      "email": emailController.text,
      "password": hpwd.toString(),
      "img": "none"
    };
    var jsonData = jsonEncode(data);
    var response = await http.post(Uri.parse(url), body: jsonData, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      print('res =' + response.body);
    } else {
      print("================" + response.body);
    }
    print("====>" + response.statusCode.toString());
    String result = response.statusCode.toString();
    return result;
  }
}
