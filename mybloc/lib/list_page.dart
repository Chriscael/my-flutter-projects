// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:mybloc/notifier/food_notifier.dart';
import 'package:mybloc/notifier/user_notifier.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    UserNotifier userNotifier =
        Provider.of<UserNotifier>(context, listen: false);

    print('List page Rebuilt');

    return Scaffold(
        appBar: AppBar(
          title: Text(userNotifier.userName),
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      Text(foodNotifier.foodList[index].name),
                  itemCount: foodNotifier.foodList.length,
                ),
              ),
              SizedBox(height: 100),
              Selector<UserNotifier, int>(
                selector: (context, user) => user.userAge,
                builder: (context, age, child) {
                  print('user name widget built');
                  return Text(age.toString());
                },
              ),
              Consumer<UserNotifier>(
                builder: (context, user, child) {
                  print('user name widget built'); 
                  return Text(user.userName);
                },
              ),
              ElevatedButton(
                child: Text(
                  'Button 1',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () => userNotifier.setUserName('yo my guy'),
              ),
              ElevatedButton(
                child: Text(
                  'Button 2',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                ),
                onPressed: () => userNotifier.incrementAge(),
              ),
            ],
          ),
        ));
  }
}
