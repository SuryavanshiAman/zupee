



import 'package:flutter/material.dart';

class FirebaseViewModel with ChangeNotifier {
  int _table = 1;
  int _myPosition = 0;

  int get table => _table;
  int get myPosition => _myPosition;

  setTable(int value) {
    _table = value;
    // notifyListeners();
  }
  setMyPosition(int value) {
    _myPosition = value;
    // notifyListeners();
  }
}