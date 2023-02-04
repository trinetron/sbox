import 'package:flutter/material.dart';
import 'package:sbox/ui/screens/card_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';

class RadioProvider extends ChangeNotifier {
  int data = 1;
  int lastD = 1;

  void changeInt(var newInt, context) {
    data = newInt;
    radioControl(data, context);
    notifyListeners();
  }

  void radioControl(int d, context) {
    switch (d) {
      case 1:
        if (d != lastD) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainScreen()));
          lastD = d;
        }
        break;
      case 2:
        if (d != lastD) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CardScreen()));
          lastD = d;
        }
        break;
      default:
    }
  }
}
