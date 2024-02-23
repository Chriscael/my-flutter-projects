import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mybloc/model/food.dart';

class FoodNotifier with ChangeNotifier {
  final List<Food> _foodList = [];

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);

  void addFood(Food food) {
    _foodList.add(food);
    notifyListeners();
  }
}
