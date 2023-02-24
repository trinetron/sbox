import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/sound_provider.dart';

class MenuProvider extends ChangeNotifier {
  double dataH = 53;
  double dataW = 54;

  final hiveSetting = HiveSetting();
  String msg = '';
  String oldMsg = '';
  bool oldFlgTap = false;

  Future<void> changeTap(bool flgTap) async {
    //flgTap = newInt;

    if ((flgTap) && (flgTap != oldFlgTap)) {
      dataH = 125;
      dataW = 125;
      notifyListeners();
    }
    if ((!flgTap) && (flgTap != oldFlgTap)) {
      dataH = 53;
      dataW = 54;
      notifyListeners();
    }
    oldFlgTap = flgTap;
  }

  menuSet(String val, BuildContext context) async {
    if (oldMsg != val) {
      var arr = val.split(':');
      if (oldMsg == '') {
        oldMsg = '1:1:1';
      }
      var arr2 = oldMsg.split(':');
      if (arr[0] != arr2[0]) {
        if (arr[0] == 'en') {
          context.setLocale(const Locale('en'));
        }
        if (arr[0] == 'ru') {
          context.setLocale(const Locale('ru'));
        }
        if (arr[0] == 'fr') {
          context.setLocale(const Locale('fr'));
        }
        if (arr[0] == 'es') {
          context.setLocale(const Locale('es'));
        }
        if (arr[0] == 'zh') {
          context.setLocale(const Locale('zh'));
        }
      }
      if ((arr[2] == 'soundON') && (arr2[2] != 'soundON')) {
        context.read<SoundProvider>().sndOn(true);
        debugPrint('soundON');
      }
      if ((arr[2] == 'soundOFF') && (arr2[2] != 'soundOFF')) {
        context.read<SoundProvider>().sndOn(false);
        debugPrint('soundOFF');
      }

      if (((arr[1] == 'themeD') && (!NeumorphicTheme.isUsingDark(context))) ||
          ((arr[1] == 'themeD') && (arr[0] != arr2[0]))) {
        NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
      }
      if ((arr[1] == 'themeL') && (NeumorphicTheme.isUsingDark(context)) ||
          ((arr[1] == 'themeL') && (arr[0] != arr2[0]))) {
        NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
      }

      if (arr[3] == 'mb0_closeStat') {
        context.read<MenuProvider>().changeTap(false);
      }

      hiveSetting.writeSetting(val);
      debugPrint('hiveSetting.writeSetting(val) $val');
      return true;
    }
    oldMsg = val;
  }
}
