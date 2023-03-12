import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sbox/models/design/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final bColor = ColorsSHM();
  bool flgDark = false;

  Color txtBGColor = Color.fromARGB(255, 216, 207, 216);
  Color topColor = Color.fromARGB(255, 60, 128, 113);
  var lightSource = LightSource.topLeft;
  Color butColor = Color.fromRGBO(157, 148, 177, 1);
  var depth = 6.0;
  var intensity = 0.5;

  Color fillSelectedColor = Color.fromARGB(255, 228, 95, 255);
  Color buttonText = Color.fromARGB(255, 0, 71, 153);
  Color fillColor = Color.fromARGB(255, 218, 190, 245);
  Color borderColor = Color.fromARGB(255, 58, 57, 57);
  Color iconColor = Color.fromARGB(255, 3, 3, 3);
  Color fillCardColor = Color.fromARGB(255, 199, 168, 202);
  Color textColor = Colors.black;

  void setThemeColor(bool flgDark) {
    if (!flgDark) {
      txtBGColor = bColor.baseColorL;
      topColor = bColor.appBarColorL;
      lightSource = bColor.lightSourceL;
      butColor = bColor.accentColorL;
      depth = bColor.depthL;
      intensity = bColor.intensityL;

      fillSelectedColor = bColor.radioFillL;
      buttonText = bColor.buttonTextL;
      fillColor = bColor.buttonFillL;
      borderColor = bColor.borderL;
      iconColor = bColor.iconL;
      fillCardColor = bColor.cardColorL;
      textColor = bColor.textColorL;
    } else {
      txtBGColor = bColor.baseColorD;
      topColor = bColor.appBarColorD;
      lightSource = bColor.lightSourceD;
      butColor = bColor.accentColorD;
      depth = bColor.depthD;
      intensity = bColor.intensityD;

      fillSelectedColor = bColor.radioFillD;
      buttonText = bColor.buttonTextD;
      fillColor = bColor.buttonFillD;
      borderColor = bColor.borderD;
      iconColor = bColor.iconD;
      fillCardColor = bColor.cardColorD;
      textColor = bColor.textColorD;
    }
    notifyListeners();
  }
}
