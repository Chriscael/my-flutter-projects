// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:path/path.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
              'my flutter app',
              style: TextStyle(fontSize: 32),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/feed'),
              child: Text('Go to feed'),
            ),
          ],
        ),
      ),
    );
  }
}
