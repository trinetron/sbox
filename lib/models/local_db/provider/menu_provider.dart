import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/models/local_db/provider/sound_provider.dart';

class MenuProvider extends ChangeNotifier {
  double dataH = 53;
  double dataW = 54;

  final hiveSetting = HiveSetting();
  String msg = '';

  void changeTap(bool flgTap) {
    //flgTap = newInt;

    if (flgTap) {
      dataH = 125;
      dataW = 125;
    } else {
      dataH = 53;
      dataW = 54;
    }
    notifyListeners();
  }

  menuSet(String val, BuildContext context) async {
    var arr = val.split(':');

    if (arr[0] == 'en') {
      context.setLocale(Locale('en'));
    }
    if (arr[0] == 'ru') {
      context.setLocale(Locale('ru'));
    }
    if (arr[0] == 'fr') {
      context.setLocale(Locale('fr'));
    }
    if (arr[0] == 'es') {
      context.setLocale(Locale('es'));
    }
    if (arr[0] == 'zh') {
      context.setLocale(Locale('zh'));
    }

    if (arr[2] == 'soundON') {
      context.read<SoundProvider>().sndOn(true);
      debugPrint('soundON');
    } else {
      context.read<SoundProvider>().sndOn(false);
      debugPrint('soundOFF');
    }

    if (arr[1] == 'themeD') {
      NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
    } else {
      NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
    }

    if (arr[3] == 'mb0_closeStat') {
      context.read<MenuProvider>().changeTap(false);
    }

    hiveSetting.writeSetting(val);
    debugPrint('hiveSetting.writeSetting(val) $val');
    return true;
  }
}
