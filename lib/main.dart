import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/local_db/provider/db_provider.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';

import 'models/local_db/hive_setting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() async {
  // await DefaultCacheManager().emptyCache();
  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ChiveAdapter());

  //final Function(String) onCountChanged;

  // var menuObj = MenuScreen;
  // MenuScreen menuObj;
  // String abc = 'sdfsdf';
  //  menuObj.settingMsg;

  //onCountChanged(box.get('setting'));

  // Future(() async {
  //   print('Running the Future');
  //   String str = await asa.readSetting();
  //   aza.menuSet(str);
  // }).then((_) async {
  //   print('Future is complete');
  //   // aza.menuSet(str);
  // });

  // aza.menuSet(await asa.readSetting());
  // debugPrint('>>>aza.menuSet $str');

  //asa.writeSetting('vsssssal');
  //Future<String> axx = asa.readSetting();

  // final Function(String) menuSet2;
  // menuSet2(box.get('name').toString());

  // menuSet2: (String val) {

  //       setState(() => menuSet(val));
  //     },

  // var boxObj = MainScreenState;
  // MainScreenState boxObj;
  // var aaa = boxObj.menuSet('sdfasdf');

  //boxObj. .menuSet(box.get('name').toString());
  //Text('Name: ${box.get('name').toString()}');

  @override
  void dispose() async {
    Hive.close();
  }

  //var key = Hive.generateSecureKey();

  String keyUsr = '12345';
  String keyMix = '';
  String key = 'ED+AB1y5hSnt353cw0E4yZ/nd3xDT/VkVgFozawPYJY=';
  debugPrint(key);

  keyMix = key.replaceRange(0, keyUsr.length, keyUsr);

  debugPrint('keyMix $keyMix');

  final keyEnc = base64.decode(keyMix);
  debugPrint(keyEnc.toString());
  await Hive.openBox<C_hive>(HiveBoxes.db_hive, encryptionKey: keyEnc);
  // await Hive.openBox<C_hive>(HiveBoxes.db_hive);

  //    Localozation init
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ru')],
    path: 'lib/models/languages',
    fallbackLocale: Locale('en'),
    child: ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(),
      child: SboxApp(),
    ),
  ));
}
