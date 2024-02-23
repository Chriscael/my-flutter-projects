import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  late FirebaseAuth _user;

  FirebaseAuth get user => _user;

  void setUser(FirebaseAuth user) {
    _user = user;
    notifyListeners();
  }
}
