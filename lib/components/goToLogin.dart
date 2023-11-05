import 'package:demo/menu/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class goToLoginPage extends StatefulWidget {
  const goToLoginPage({super.key});

  @override
  State<goToLoginPage> createState() => _goToLoginPageState();
}

class _goToLoginPageState extends State<goToLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => signInPage()));
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
