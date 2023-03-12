import 'package:flutter/material.dart';
import 'package:sbox/ui/screens/card_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';

class RadioProvider extends ChangeNotifier {
  int data = 1;
  int lastD = 1;

  void changeInt(var newInt, context) {
    data = newInt;
    notifyListeners();
    radioControl(data, context);
  }

  void changelastD() {
    lastD = data;
    notifyListeners();
  }

  void radioControl(int d, context) {
    debugPrint('d = $d');
    debugPrint('lastD = $lastD');
    switch (d) {
      case 1:
        if ((d != lastD) || (lastD == 0)) {
          debugPrint('radioControl case 1');
          Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => MainScreen()),
            (Route<dynamic> route) => false,
          );
          // if (d != 0) {

          //}
        }
        lastD = d;

        break;
      case 2:
        if ((d != lastD) || (lastD == 0)) {
          debugPrint('radioControl case 2');
          Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (context, a1, a2) => CardScreen()),
            (Route<dynamic> route) => false,
          );
          //if (d != 0) {

          //}
        }
        lastD = d;
        break;
      default:
        lastD = d;
    }
  }
}
