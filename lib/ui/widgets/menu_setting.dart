import 'dart:io';

import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/ui/screens/main_screen.dart';

class MenuScreen extends StatelessWidget {
  final Function(String) onMenuChanged;
  String message = '';
  String? msg = ''; // ?-может принимать Null

  MenuScreen({
    // super.key,
    this.msg,
    required this.onMenuChanged, //обязательный вызов
  });

  late StateMachineController controller;

  SMIInput<bool>? _bump;
  SMIInput<bool>? _bSettingTemp;
  SMIInput<bool>? _bSndTemp;
  SMIInput<bool>? _bLngTemp;
  SMIInput<bool>? _bLDTTemp;
  SMIInput<bool>? _bSOnTemp;
  SMIInput<bool>? _bSOffTemp;
  SMIInput<bool>? _bEnTemp;
  SMIInput<bool>? _bRuTemp;
  SMIInput<bool>? _bDTemp;
  SMIInput<bool>? _bFrTemp;
  SMIInput<bool>? _bLTemp;
  SMIInput<bool>? _bEsTemp;
  SMIInput<bool>? _bZhTemp;

  void onInit(Artboard artboard) async {
    controller = StateMachineController.fromArtboard(
      artboard,
      'SM1',
      onStateChange: onStateChange,
    ) as StateMachineController;
    //controller.isActive = true;

    artboard.addController(controller);

    var asa = HiveSetting();
    String msgSetting = '';
    //msgSetting = 'themeL:ru:soundOFF';

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appPath = appDocDir.path.toString().toLowerCase() + '/sbox';

    var box = await Hive.openBox('setBox', crashRecovery: true, path: appPath);

    var tmpSet = await box.get('settings');
    if (tmpSet != null) {
      msgSetting = tmpSet;
    } else {
      msgSetting = 'themeL:soundOFF:mb0_closeStat';
    }
    //msgSetting = await asa.readSetting();

    var arr = msgSetting.split(':');
    debugPrint('arr = $arr');

    if (arr[0] == 'en') {
      controller.findInput<bool>('in_bFr')!.value = false;
      controller.findInput<bool>('in_bEn')!.value = true;
      controller.findInput<bool>('in_bRu')!.value = false;
      controller.findInput<bool>('in_bEs')!.value = false;
      controller.findInput<bool>('in_bZh')!.value = false;
    }
    if (arr[0] == 'ru') {
      controller.findInput<bool>('in_bFr')!.value = false;
      controller.findInput<bool>('in_bEn')!.value = false;
      controller.findInput<bool>('in_bRu')!.value = true;
      controller.findInput<bool>('in_bEs')!.value = false;
      controller.findInput<bool>('in_bZh')!.value = false;
    }
    if (arr[0] == 'fr') {
      controller.findInput<bool>('in_bFr')!.value = true;
      controller.findInput<bool>('in_bEn')!.value = false;
      controller.findInput<bool>('in_bRu')!.value = false;
      controller.findInput<bool>('in_bEs')!.value = false;
      controller.findInput<bool>('in_bZh')!.value = false;
    }
    if (arr[0] == 'es') {
      controller.findInput<bool>('in_bFr')!.value = false;
      controller.findInput<bool>('in_bEn')!.value = false;
      controller.findInput<bool>('in_bRu')!.value = false;
      controller.findInput<bool>('in_bEs')!.value = true;
      controller.findInput<bool>('in_bZh')!.value = false;
    }
    if (arr[0] == 'zh') {
      controller.findInput<bool>('in_bFr')!.value = false;
      controller.findInput<bool>('in_bEn')!.value = false;
      controller.findInput<bool>('in_bRu')!.value = false;
      controller.findInput<bool>('in_bEs')!.value = false;
      controller.findInput<bool>('in_bZh')!.value = true;
    }

    if (arr[2] == 'soundON') {
      controller.findInput<bool>('in_bSOn')!.value = true;
      controller.findInput<bool>('in_bSOff')!.value = false;
    } else {
      controller.findInput<bool>('in_bSOn')!.value = false;
      controller.findInput<bool>('in_bSOff')!.value = true;
    }

    if (arr[1] == 'themeD') {
      controller.findInput<bool>('in_bL')!.value = false;
      controller.findInput<bool>('in_bD')!.value = true;
    } else {
      controller.findInput<bool>('in_bL')!.value = true;
      controller.findInput<bool>('in_bD')!.value = false;
    }
  }

  void onStateChange(String stateMachineName, String stateName) async {
    message = 'State Changed in $stateMachineName to $stateName';
    debugPrint(message);

    _bSettingTemp = controller.findInput<bool>('in_bSetting') as SMIBool;
    _bSndTemp = controller.findInput<bool>('in_bSnd') as SMIBool;
    _bLngTemp = controller.findInput<bool>('in_bLng') as SMIBool;
    _bLDTTemp = controller.findInput<bool>('in_bLDT') as SMIBool;

    _bSOnTemp = controller.findInput<bool>('in_bSOn') as SMIBool;
    _bSOffTemp = controller.findInput<bool>('in_bSOff') as SMIBool;
    _bEnTemp = controller.findInput<bool>('in_bEn') as SMIBool;
    _bRuTemp = controller.findInput<bool>('in_bRu') as SMIBool;
    _bDTemp = controller.findInput<bool>('in_bD') as SMIBool;
    _bFrTemp = controller.findInput<bool>('in_bFr') as SMIBool;
    _bLTemp = controller.findInput<bool>('in_bL') as SMIBool;
    _bEsTemp = controller.findInput<bool>('in_bEs') as SMIBool;
    _bZhTemp = controller.findInput<bool>('in_bZh') as SMIBool;

    // message = _bSettingTemp!.value.toString();
    // message += ':  in_bSnd:';
    // message += _bSndTemp!.value.toString();
    // message += ' in_bLng:';
    // message += _bLngTemp!.value.toString();
    // message += ' in_bLD:';
    // message += _bLDTTemp!.value.toString();
    // message += ' in_bSOn:';
    // message += _bSOnTemp!.value.toString();
    // message += ' in_bSOff:';
    // message += _bSOffTemp!.value.toString();
    // message += ' in_bEn:';
    // message += _bFrTemp!.value.toString();
    // message += ' in_bRu:';
    // message += _bEnTemp!.value.toString();
    // message += ' in_bD:';
    // message += _bRuTemp!.value.toString();
    // message += ' in_bFr:';
    // message += _bLTemp!.value.toString();
    // message += ' in_bL:';
    // message += _bDTemp!.value.toString();

    // debugPrint('readButtonMenu $message');

    message = '';

    if (_bEnTemp!.value == true) {
      //context.setLocale(Locale('en'));
      message += 'en:';
    }
    if (_bFrTemp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'fr:';
    }
    if (_bRuTemp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'ru:';
    }
    if (_bEsTemp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'es:';
    }
    if (_bZhTemp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'zh:';
    }
    if (message == '') {
      // context.setLocale(Locale('ru'));
      message += 'en:';
    }

    if ((_bDTemp!.value == true) && (_bLTemp!.value == false)) {
      // NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
      message += 'themeD:';
    } else {
      //NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
      message += 'themeL:';
    }

    if ((_bSOnTemp!.value == true) && (_bSOffTemp!.value == false)) {
      // context.setLocale(Locale('ru'));
      message += 'soundON:';
    } else {
      // context.setLocale(Locale('ru'));
      message += 'soundOFF:';
    }

    message += stateName;
    // message = 'en:themeL:soundOFF';
    onMenuChanged(message);
  }

//open menu
  void hitBump() {
    if (controller.findInput<bool>('in_bSetting')!.value == true) {
      controller.findInput<bool>('in_bSetting')!.value = false;
    } else {
      controller.findInput<bool>('in_bSetting')!.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      // fit: BoxFit.contain,
      // fit: BoxFit.cover,
      // fit: BoxFit.fill,
      fit: BoxFit.none,
      // fit: BoxFit.fitHeight,
      // fit: BoxFit.fitWidth,
      // fit: BoxFit.scaleDown,
      'assets/menu4.riv',
      onInit: onInit,
      alignment: Alignment.topRight,
    );
  }
}
