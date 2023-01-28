import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  bool initialized = false;
  bool error = false;

  String menuSetting = '';

  void changeInit(var newInit) {
    initialized = newInit;
    notifyListeners();
  }

  void changeErrState(var newErr) {
    error = newErr;
    notifyListeners();
  }

  void changeMenuSet(String newSet) {
    menuSetting = newSet;
    notifyListeners();
  }
}
