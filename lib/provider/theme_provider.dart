import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sbox/models/design/theme.dart';

class ThemeProvider extends ChangeNotifier {
  final bColor = ColorsSHM();
  bool flgDark = false;

  Color txtBGColor = Colors.black;
  Color topColor = Colors.black;
  LightSource lightSource = LightSource.topLeft;
  Color butColor = Colors.black;
  double depth = 6.0;
  double intensity = 0.5;

  Color fillSelectedColor = Colors.black;
  Color buttonText = Colors.black;
  Color fillColor = Colors.black;
  Color borderColor = Colors.black;
  Color iconColor = Colors.black;
  Color fillCardColor = Colors.black;
  Color textColor = Colors.black;

  Color baseColor = Colors.black;
  Color variantColor = Colors.black;
  Color accentColor = Colors.black;

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

      baseColor = bColor.baseColorL;
      variantColor = bColor.appBarColorL;
      accentColor = bColor.accentColorL;
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

      baseColor = bColor.baseColorD;
      variantColor = bColor.appBarColorD;
      accentColor = bColor.accentColorD;
    }
    notifyListeners();
  }
}
