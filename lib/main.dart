import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/screens/main_screen.dart';
import 'package:sbox/models/secstor.dart';
import 'package:sbox/client/hive_names.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(ChiveAdapter());
  await Hive.openBox<C_hive>(HiveBoxes.db_hive);

  //    Localozation init
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ru')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    child: SboxApp(),
  ));
}
