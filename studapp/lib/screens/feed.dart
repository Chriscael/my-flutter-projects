// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class Feed extends StatelessWidget {
  const Feed({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feed",
        ),
        actions: <Widget>[
          // action button
          TextButton(
            onPressed: () {},
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Feed",
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
