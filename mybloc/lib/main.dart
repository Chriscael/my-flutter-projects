// ignore_for_file: prefer_const_constructors

import 'package:mybloc/notifier/food_notifier.dart';
import 'package:mybloc/notifier/user_notifier.dart';
import 'package:provider/provider.dart';

import 'home.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              (context) => FoodNotifier();
            },
          ),
          ChangeNotifierProvider(
            create: (BuildContext context) {
              (context) => UserNotifier('chris coding');
            },
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my soft coding',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
