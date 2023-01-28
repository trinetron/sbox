import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';

import '/models/local_db/secstor.dart';
import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';

class DatabaseProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String pass = '';
  bool initialized = false;
  bool dbFilesExist = false;
  bool msgFilesExist = false;

  String msgSetting = '';
  final hiveSetting = HiveSetting();

  @override
  void dispose() async {
    Hive.close();
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  late Box<C_hive> _boxA = Hive.box<C_hive>(HiveBoxes.db_hive);

  late C_hive _selectedboxA = C_hive();

  Box<C_hive> get boxA => _boxA;

  C_hive get selectedboxA => _selectedboxA;

  ///* Updating the current selected index for that contact to pass to read from hive
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    updateSelectedContact();
    notifyListeners();
  }

  ///* Updating the current selected item from hive
  void updateSelectedContact() {
    _selectedboxA = readFromHive()!;
    notifyListeners();
  }

  ///* reading the current selected item from hive
  C_hive? readFromHive() {
    C_hive? getItem = _boxA.getAt(_selectedIndex);

    return getItem;
  }

  void deleteFromHive() {
    _boxA.deleteAt(_selectedIndex);
    debugPrint(' _boxA.deleteAt   $_selectedIndex ');
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  bool get isAuth {
    return initialized != false;
  }

  void msgdbFilesExists(var val) {
    msgFilesExist = val;
  }

  Future<bool> dbFilesExists() async {
    if ((await Hive.boxExists(HiveBoxes.db_hive)) &&
        (await Hive.boxExists(HiveBoxes.db_hiveCard))) {
// dbFilesExist = true;
// msgFilesExist = true;
      return true;
    } else {
      return false;
    }
  }

  void changeDataLogin(String val) {
    pass = val;
    // if (pass == 'xxx') {
    //   initialized = true;
    // }
    debugPrint('pass  $pass');
    notifyListeners();
  }

  initConfig(context) async {
    try {
      msgSetting = await hiveSetting.readSetting();
      await context.read<MenuProvider>().menuSet(msgSetting, context);
      debugPrint('initConfig try run: ---');
      //notifyListeners();
    } catch (e) {
      debugPrint('initConfig error caught: $e');
      debugPrint('err run: ---');
    }
  }

  initSecBD(BuildContext context) async {
    try {
      //var key = Hive.generateSecureKey();
      //String keyUsr = '12345';
      String keyUsr = pass;
      String keyMix = '';
      String key = 'ED+AB1y5hSnt353cw0E4yZ/nd3xDT/VkVgFozawPYJY=';
      debugPrint(key);

      keyMix = key.replaceRange(0, keyUsr.length, keyUsr);

      debugPrint('keyMix $keyMix');

      final keyEnc = base64.decode(keyMix);
      debugPrint(keyEnc.toString());

      var boxSite = await Hive.openBox<C_hive>(HiveBoxes.db_hive,
          encryptionCipher: HiveAesCipher(keyEnc), crashRecovery: false);
      var boxCard = await Hive.openBox<C_hiveCard>(HiveBoxes.db_hiveCard,
          encryptionCipher: HiveAesCipher(keyEnc), crashRecovery: false);

      if ((boxSite != null) && (boxCard != null)) {
        context.read<StateProvider>().changeInit(true);
        context.read<StateProvider>().changeErrState(false);
        notifyListeners();
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      } else {
        context.read<StateProvider>().changeErrState(false);
        context.read<StateProvider>().changeInit(false);
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(LocaleKeys.pass_err.tr()),
        ));
      }

      debugPrint('initSecBD try run: ---');
    } catch (e, s) {
      debugPrint('initSecBD error caught: $e');
      debugPrint('initSecBD error Стек: $s');

      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(LocaleKeys.pass_err.tr()),
      // ));

      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));

      debugPrint('initSecBD err run: ---');
    } finally {
      //
      // context.read<StateProvider>().changeInit(true);
      // notifyListeners();
      // await Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => MainScreen()));
    }
  }
}
