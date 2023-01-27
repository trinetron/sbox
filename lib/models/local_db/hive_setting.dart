import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  @override
  void dispose() async {
    Hive.close();
  }

  readSetting() async {
    var box = await Hive.openBox('setBox');
    var res = box.get('settings');
    // box.close();
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
    var box = await Hive.openBox('setBox');
    box.put('settings', writeStr);
    debugPrint('settings, = $writeStr');
    // box.close();
  }
}
