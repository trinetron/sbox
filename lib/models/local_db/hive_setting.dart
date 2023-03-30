import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveSetting {
  //final VoidCallback onCountSelected;
  // final Function(String) onWriteSetting;
  //final Function(String) onReadSetting;

  //Function writeSetting(String writeStr);
  //String writeStr;

  //HiveSetting({
  // required this.onWriteSetting,
  // required this.onReadSetting,
  // this.writeSetting(),
  // this.writeStr = '',
  //});

  // var box;

  // @override
  // void dispose() async {
  //   Hive.close();
  // }

  readSetting() async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path + '/sbox';
    late var box;

    if (!Hive.isBoxOpen('setBox')) {
      box = await Hive.openBox('setBox', path: appPath);
    }
    // if (box.isEmpty) {
    //   await box.put('settings', 'themeL:en:soundOFF:mb0_closeStat');
    // }
    var res = await box.get('settings');
    //await box.close();
    if ((res != '') && (res != null)) {
      debugPrint('return res.toString(); $res.toString()');
      return res.toString();
    } else {
      debugPrint('return themeD, en, soundON, mb0_closeStat;');
      return 'themeD:en:soundON:mb0_closeStat';
    }
    // onReadSetting(box.get('settings'));
  }

  writeSetting(String writeStr) async {
    Directory? appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path + '/sbox';
    var box = await Hive.openBox('setBox', path: appPath);

    await box.clear();
    await box.flush();
    await box.put('settings', writeStr);
    debugPrint('settings, = $writeStr');
    //await box.close();
  }
}
