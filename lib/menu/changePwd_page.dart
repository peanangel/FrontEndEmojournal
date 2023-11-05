import 'package:demo/menu/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyResetPasswordPage extends StatefulWidget {
  const MyResetPasswordPage({super.key});
  @override
  State<MyResetPasswordPage> createState() => _MyResetPasswordPageState();
}

class _MyResetPasswordPageState extends State<MyResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //key: scaffoldKey,
        appBar: AppBar(
          title: Text("Forget password", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            color: Colors.green[50],
            child: Center(
                child: ListView(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 196, 242, 236),
                          Color.fromARGB(255, 186, 230, 221)
                        ])),
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                        const Image(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/2602/2602410.png?ga=GA1.1.1317775886.1691651465'),
                          height: 120,
                          width: 120,
                        ),
                        Text("Emojournal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black)),
                        TextFieldEmail(),
                        ButtonSignUp(context)
                      ],
                    )),
              ],
            ))));
  }

  InkWell ButtonSignUp(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Reset password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromARGB(255, 192, 238, 167)),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(12)),
        onTap: () => navigateToMyLogin(context));
  }

  navigateToMyLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const signInPage()));
  }

  Container TextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            //controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 18)));
  }
}
