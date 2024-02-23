// ignore_for_file: unnecessary_null_comparison, use_key_in_widget_constructors, prefer_const_constructors
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:studapp/screens/feed.dart';
import 'package:studapp/screens/login.dart';
import 'package:flutter/material.dart';

import 'notifier/auth_notifier.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              AuthNotifier();
            },
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coding with Curry',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        //accentColor: Colors.blue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? Feed() : Login();
        },
      ),
    );
  }
}
