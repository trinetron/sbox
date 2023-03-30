import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/local_db/secstor_card_tmp.dart';
import 'package:sbox/models/local_db/secstor_tmp.dart';
import 'package:sbox/provider/add_card_provider.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/radio_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:window_manager/window_manager.dart';

import 'models/local_db/hive_setting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() async {
  //await DefaultCacheManager().emptyCache();
  // await Hive.deleteBoxFromDisk('shopping_box');

  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ChiveAdapter());
  Hive.registerAdapter(ChiveCardAdapter());
  Hive.registerAdapter(ChivetmpAdapter());
  Hive.registerAdapter(ChiveCardtmpAdapter());

  if ((Platform.isWindows) || (Platform.isIOS) || (Platform.isLinux)) {
    // windowManager initialization
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(400, 850),
      minimumSize: Size(400, 500),
      center: false,
      title: 'sBox',
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

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
        ChangeNotifierProvider<SoundProvider>(
          create: (context) => SoundProvider(),
        ),
        ChangeNotifierProvider<StateProvider>(
          create: (context) => StateProvider(),
        ),
        ChangeNotifierProvider<AddCardProvider>(
          create: (context) => AddCardProvider(),
        ),
        ChangeNotifierProvider<PermissionsService>(
          create: (context) => PermissionsService(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
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
          // baseColor: bColor.baseColorL,
          // variantColor: bColor.appBarColorL,
          // lightSource: bColor.lightSourceL,
          // accentColor: bColor.accentColorL,
          // depth: bColor.depthL,
          ),
      darkTheme: NeumorphicThemeData(
          // baseColor: bColor.baseColorD,
          // variantColor: bColor.appBarColorD,
          // lightSource: bColor.lightSourceD,
          // accentColor: bColor.accentColorD,
          // depth: bColor.depthD,
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
