import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
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
  SMIInput<bool>? _b0Temp;
  SMIInput<bool>? _b11Temp;
  SMIInput<bool>? _b12Temp;
  SMIInput<bool>? _b13Temp;
  SMIInput<bool>? _b21Temp;
  SMIInput<bool>? _b221Temp;
  SMIInput<bool>? _b23Temp;
  SMIInput<bool>? _b242Temp;
  SMIInput<bool>? _b25Temp;
  SMIInput<bool>? _b222Temp;
  SMIInput<bool>? _b243Temp;

  void onInit(Artboard artboard) async {
    controller = StateMachineController.fromArtboard(
      artboard,
      'SM1',
      onStateChange: onStateChange,
    ) as StateMachineController;
    // ctrl.isActive = true;

    artboard.addController(controller);

    var asa = HiveSetting();
    String msgSetting = '';
    msgSetting = 'themeL:ru:soundOFF';

    var box = await Hive.openBox('setBox');
    msgSetting = await box.get('settings');

    //msgSetting = await asa.readSetting();

    var arr = msgSetting.split(':');
    debugPrint('arr = $arr');

    if (arr[0] == 'en') {
      controller.findInput<bool>('in_b2-2_2')!.value = false;
      controller.findInput<bool>('in_b2-3')!.value = true;
      controller.findInput<bool>('in_b2-4_2')!.value = false;
    }
    if (arr[0] == 'ru') {
      controller.findInput<bool>('in_b2-2_2')!.value = false;
      controller.findInput<bool>('in_b2-3')!.value = false;
      controller.findInput<bool>('in_b2-4_2')!.value = true;
    }
    if (arr[0] == 'fr') {
      controller.findInput<bool>('in_b2-2_2')!.value = true;
      controller.findInput<bool>('in_b2-3')!.value = false;
      controller.findInput<bool>('in_b2-4_2')!.value = false;
    }

    if (arr[2] == 'soundON') {
      controller.findInput<bool>('in_b2-1')!.value = true;
      controller.findInput<bool>('in_b2-2_1')!.value = false;
    } else {
      controller.findInput<bool>('in_b2-1')!.value = false;
      controller.findInput<bool>('in_b2-2_1')!.value = true;
    }

    if (arr[1] == 'themeD') {
      controller.findInput<bool>('in_b2-4_3')!.value = false;
      controller.findInput<bool>('in_b2-5')!.value = true;
    } else {
      controller.findInput<bool>('in_b2-4_3')!.value = true;
      controller.findInput<bool>('in_b2-5')!.value = false;
    }
  }

  void onStateChange(String stateMachineName, String stateName) async {
    message = 'State Changed in $stateMachineName to $stateName';
    debugPrint(message);

    _b0Temp = controller.findInput<bool>('in_b0') as SMIBool;
    _b11Temp = controller.findInput<bool>('in_b1-1') as SMIBool;
    _b12Temp = controller.findInput<bool>('in_b1-2') as SMIBool;
    _b13Temp = controller.findInput<bool>('in_b1-3') as SMIBool;

    _b21Temp = controller.findInput<bool>('in_b2-1') as SMIBool;
    _b221Temp = controller.findInput<bool>('in_b2-2_1') as SMIBool;
    _b23Temp = controller.findInput<bool>('in_b2-3') as SMIBool;
    _b242Temp = controller.findInput<bool>('in_b2-4_2') as SMIBool;
    _b25Temp = controller.findInput<bool>('in_b2-5') as SMIBool;
    _b222Temp = controller.findInput<bool>('in_b2-2_2') as SMIBool;
    _b243Temp = controller.findInput<bool>('in_b2-4_3') as SMIBool;

    message = _b0Temp!.value.toString();
    message += ':  1-1:';
    message += _b11Temp!.value.toString();
    message += ' 1-2:';
    message += _b12Temp!.value.toString();
    message += ' 1-3:';
    message += _b13Temp!.value.toString();
    message += ' 2-1:';
    message += _b21Temp!.value.toString();
    message += ' 2-2_1:';
    message += _b221Temp!.value.toString();
    message += ' 2-2_2:';
    message += _b222Temp!.value.toString();
    message += ' 2-3:';
    message += _b23Temp!.value.toString();
    message += ' 2-4_2:';
    message += _b242Temp!.value.toString();
    message += ' 2-4_3:';
    message += _b243Temp!.value.toString();
    message += ' 2-5:';
    message += _b25Temp!.value.toString();

    debugPrint('readButtonMenu $message');

    message = '';

    if (_b23Temp!.value == true) {
      //context.setLocale(Locale('en'));
      message += 'en:';
    }
    if (_b222Temp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'fr:';
    }
    if (_b242Temp!.value == true) {
      // context.setLocale(Locale('ru'));
      message += 'ru:';
    }
    if (message == '') {
      // context.setLocale(Locale('ru'));
      message += 'en:';
    }

    if ((_b25Temp!.value == true) && (_b243Temp!.value == false)) {
      // NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
      message += 'themeD:';
    } else {
      //NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
      message += 'themeL:';
    }

    if ((_b21Temp!.value == true) && (_b221Temp!.value == false)) {
      // context.setLocale(Locale('ru'));
      message += 'soundON';
    } else {
      // context.setLocale(Locale('ru'));
      message += 'soundOFF';
    }
    // message = 'en:themeL:soundOFF';
    onMenuChanged(message);
  }

//open menu
  void hitBump() {
    if (controller.findInput<bool>('in_b0')!.value == true) {
      controller.findInput<bool>('in_b0')!.value = false;
    } else {
      controller.findInput<bool>('in_b0')!.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/menu2.riv',
      onInit: onInit,
    );
  }
}
