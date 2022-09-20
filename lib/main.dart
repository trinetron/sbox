import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'generated/locale_keys.g.dart';
import 'screens/add_secstor/add_secstor.dart';
import 'models/secstor.dart';
import 'client/hive_names.dart';
import 'package:easy_localization/easy_localization.dart';
import '../generated/codegen_loader.g.dart';

void main() async {
  //   hive initialization
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<C_hive>(HiveBoxes.db_hive);

  //    Localozation init
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ru')],
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    child: SboxApp(),
  ));
}

class SboxApp extends StatefulWidget {
  @override
  _SboxAppState createState() => _SboxAppState();
}

class _SboxAppState extends State<SboxApp> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Box',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        // Theme App (основная тема приложения)
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(title: 'Secret Box'),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.language),
          onPressed: () {
            if (context.locale == Locale('ru')) {
              context.setLocale(Locale('en'));
            } else {
              context.setLocale(Locale('ru'));
            }
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<C_hive>(HiveBoxes.db_hive).listenable(),
        builder: (context, Box<C_hive> box, _) {
          if (box.values.isEmpty)
            return Center(
              child: Text(
                LocaleKeys.Box_is_empty.tr(),
              ),
            );
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              C_hive? res = box.getAt(index);
              return Dismissible(
                background: Container(color: Color.fromARGB(255, 158, 54, 244)),
                key: UniqueKey(),
                onDismissed: (direction) {
                  res?.delete();
                },
                child: ListTile(
                    title: Text(res!.task),
                    subtitle: Text(res.note),
                    leading: res.complete
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank),
                    onTap: () {
                      res.complete = !res.complete;
                      res.save();
                    }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddTodo())),
        tooltip: LocaleKeys.Add.tr(),
        child: Icon(Icons.add),
      ),
    );
  }
}
