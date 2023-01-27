import 'package:flutter/material.dart';

class RadioProvider extends ChangeNotifier {
  int data = 1;

  void changeInt(var newInt) {
    data = newInt;
    notifyListeners();
  }
}
