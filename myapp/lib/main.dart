// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/pages/detail.dart';
import './pages/login.dart';
import './pages/feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cabrel is coding',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      // routes: {
      //   '/login': (context) => const LoginPage(),
      //   '/feed': (context) => const FeedPage(),
      //   '/detail': (context) => const DetailPage(),
      // },
      onGenerateRoute: (RouteSettings settings) {
        // /detailId/5
        final List<String> pathElements = settings.name!.split('/');

        if (pathElements[0] != '') {
          return null;
        }

        switch (pathElements[1]) {
          case 'login':
            return MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            );

          case 'feed':
            return MaterialPageRoute(
              builder: (BuildContext context) => FeedPage(),
            );

          case 'detailId':
            final String detailId = pathElements[2];

            // ignore: avoid_print
            print("DetailId: $detailId");

            if (detailId.isEmpty) {
              return MaterialPageRoute(
                builder: (BuildContext context) => DetailPage("no detail"),
              );
            }

            String itemName = "Item Detail: $detailId";

            return MaterialPageRoute(
              builder: (BuildContext context) => DetailPage(itemName), 
            );

          default:
            return null;
        }
      },
    );
  }
}
