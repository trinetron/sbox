import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/provider/add_card_provider.dart';
import 'package:sbox/provider/add_site_provider.dart';
import 'package:sbox/provider/edit_card_provider.dart';
import 'package:sbox/provider/edit_site_provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/radio_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';

import 'models/local_db/hive_setting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() async {
  //await DefaultCacheManager().emptyCache();
  // await Hive.deleteBoxFromDisk('shopping_box');

  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ChiveAdapter());
  Hive.registerAdapter(ChiveCardAdapter());
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

  //    Localozation init
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('ru'),
      Locale('fr'),
      Locale('es'),
      Locale('zh'),
    ],
    path: 'lib/models/languages',
    fallbackLocale: Locale('en'),
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(),
        ),
        ChangeNotifierProvider<RadioProvider>(
          create: (context) => RadioProvider(),
        ),
        ChangeNotifierProvider<MenuProvider>(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider<AddSiteProvider>(
          create: (context) => AddSiteProvider(),
        ),
        ChangeNotifierProvider<EditSiteProvider>(
          create: (context) => EditSiteProvider(),
        ),
        ChangeNotifierProvider<SoundProvider>(
          create: (context) => SoundProvider(),
        ),
        ChangeNotifierProvider<StateProvider>(
          create: (context) => StateProvider(),
        ),
        ChangeNotifierProvider<AddCardProvider>(
          create: (context) => AddCardProvider(),
        ),
        ChangeNotifierProvider<EditCardProvider>(
          create: (context) => EditCardProvider(),
        ),
        ChangeNotifierProvider<PermissionsService>(
          create: (context) => PermissionsService(),
        ),
      ],
      child: SboxApp(),
    ),
  ));
}

class SboxApp extends StatefulWidget {
  const SboxApp({super.key});

  @override
  SboxAppState createState() => SboxAppState();
}

class SboxAppState extends State<SboxApp> {
  final bColor = ColorsSHM();

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    // context.read<DatabaseProvider>().initConfig(context);
    ////////////initializeFlutterFire();

    super.initState();
  }

  // void initializeFlutterFire() async {
  //   try {
  //     msgSetting = await hiveSetting.readSetting();
  //     await context.read<MenuProvider>().menuSet(msgSetting, context);

  //     context.read<StateProvider>().changeInit(true);

  //     debugPrint('try run: ---');
  //   } catch (e) {
  //     debugPrint('error caught: $e');

  //     context.read<StateProvider>().changeErrState(true);

  //     debugPrint('err run: ---');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      themeMode: bColor.setThemeMode,
      theme: NeumorphicThemeData(
        baseColor: bColor.baseColorL,
        variantColor: bColor.appBarColorL,
        lightSource: bColor.lightSourceL,
        accentColor: bColor.accentColorL,
        depth: bColor.depthL,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: bColor.baseColorD,
        variantColor: bColor.appBarColorD,
        lightSource: bColor.lightSourceD,
        accentColor: bColor.accentColorD,
        depth: bColor.depthD,
      ),
      title: 'Secret Box',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
