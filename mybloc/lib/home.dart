// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mybloc/notifier/food_notifier.dart';
import 'package:provider/provider.dart';
import 'list_page.dart';
import 'model/food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late String _currentName;
  late String _currentColor;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("Provider Demo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Name'),
                initialValue: null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onSaved: (value) {
                  _currentName = value!;
                  print('Name: $value');
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Color'),
                initialValue: null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Color is required';
                  }

                  return null;
                },
                onSaved: (value) {
                  _currentColor = value!;
                  print('Color: $value');
                },
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Text(foodNotifier.foodList[index].name),
                        Text(foodNotifier.foodList[index].color),
                        Divider(
                          thickness: 2,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: foodNotifier.foodList.length,
              ),
              ElevatedButton(
                child: Text(
                  'Add Food',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  _formKey.currentState!.save();
                  setState(() {
                    foodNotifier.addFood(Food(_currentName, _currentColor));
                  });
                },
              ),
              ElevatedButton(
                child: Text(
                  'Test',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
