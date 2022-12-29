import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/models/local_db/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/ui/screens/add_site.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_mn.dart';

class SboxApp extends StatefulWidget {
  const SboxApp({super.key});

  @override
  _SboxAppState createState() => _SboxAppState();
}

class _SboxAppState extends State<SboxApp> {
  final bColor = ColorsSHM();

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      themeMode: bColor.setThemeMode,
      // theme: NeumorphicThemeData(
      //   baseColor: bColor.baseColorL,
      //   variantColor: bColor.appBarColorL,
      //   lightSource: bColor.lightSourceL,
      //   accentColor: bColor.accentColorL,
      //   depth: bColor.depthL,
      // ),
      // darkTheme: NeumorphicThemeData(
      //   baseColor: bColor.baseColorD,
      //   variantColor: bColor.appBarColorD,
      //   lightSource: bColor.lightSourceD,
      //   accentColor: bColor.accentColorD,
      //   depth: bColor.depthD,
      // ),

      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xff333333),
        accentColor: Colors.green,
        lightSource: LightSource.topLeft,
        depth: 4,
        intensity: 0.3,
      ),
      theme: NeumorphicThemeData(
        baseColor: Color(0xffDDDDDD),
        accentColor: Colors.cyan,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),

      title: 'Secret Box',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  String msg = '';

  bool _initialized = false;
  bool _error = false;

  late Box boxA;

  final hiveSetting = HiveSetting();

  String msgSetting = '';

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  menuSet(String val) async {
    var arr = val.split(':');

    if (arr[0] == 'en') {
      context.setLocale(Locale('en'));
    }
    if (arr[0] == 'ru') {
      context.setLocale(Locale('ru'));
    }
    if (arr[0] == 'fr') {
      context.setLocale(Locale('ru'));
    }

    if (arr[2] == 'soundON') {
      debugPrint('soundON');
    } else {
      debugPrint('soundOFF');
    }

    if (arr[1] == 'themeD') {
      NeumorphicTheme.of(context)!.themeMode = ThemeMode.dark;
    } else {
      NeumorphicTheme.of(context)?.themeMode = ThemeMode.light;
    }

    hiveSetting.writeSetting(val);
    debugPrint('hiveSetting.writeSetting(val) $val');
    return true;
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      msgSetting = await hiveSetting.readSetting();
      await menuSet(msgSetting);
      // debugPrint('initSetting = $_setMenuFuture');
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      debugPrint('error caught: $e');
      //_view.onLoginError();
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    boxA = Hive.box<C_hive>(HiveBoxes.db_hive);
    initializeFlutterFire();

    super.initState();
  }

  String query = '';
  TextEditingController editingController = TextEditingController();
  //late var results;

  @override
  Widget build(BuildContext context) {
    if (_error) {
      debugPrint('_error');
      debugPrint('_error   $_error');
      debugPrint('_initialized   $_initialized');

      return Text('_error');
    }

    // Show a loader until FlutterFire is initialized
    if (_initialized) {
      return SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: NeumorphicTheme.baseColor(context),
              appBar: AppBar(
                backgroundColor: NeumorphicTheme.variantColor(context),
                leading: FloatingActionButton(
                  onPressed: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddSite())),
                  },
                  tooltip: LocaleKeys.Add.tr(),
                  child: Icon(Icons.add),
                ),

                title: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 1, left: 1, right: 13.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 50,
                        width: 200,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              query = value.toLowerCase();
                            });
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (() {
                                  setState(() {
                                    editingController.clear();
                                    query = '';
                                  });
                                }),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)))),
                        ),
                      ),
                    ),
                  ),
                ),
                //Color: NeumorphicTheme.accentColor(context),
              ),
              body: Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: SizedBox(
                        height: 150,
                        child: //Text(''),
                            cbWidget(context),
                      )),
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<C_hive>(HiveBoxes.db_hive).listenable(),
                        builder: (context, Box<C_hive> box, _) {
                          DatabaseProvider databaseProvider =
                              Provider.of<DatabaseProvider>(context,
                                  listen: false);

                          // builder: (context, Box<C_hive> boxA, _) {
                          // if (boxG.values.isEmpty) {
                          //   return Center(
                          //     child: Text(
                          //       LocaleKeys.Box_is_empty.tr(),
                          //     ),
                          //   );
                          // } else
                          {
                            var results = query.isEmpty
                                ? box.values.toList() // whole list
                                : box.values
                                    .where((c) =>
                                        c.task.toLowerCase().contains(query))
                                    .toList();

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final res = results[index];
                                return Dismissible(
                                  background: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        color:
                                            Color.fromARGB(255, 158, 54, 244)),
                                  ),
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    databaseProvider.updateSelectedIndex(index);
                                    databaseProvider.deleteFromHive();
                                    //box.delete(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0,
                                        right: 18.0,
                                        top: 5.0,
                                        bottom: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.grey, //color of border
                                            width: 2, //width of border
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ButtonMN(textBtn: res.task),
                                              ButtonMN(textBtn: res.login),
                                              ButtonMN(textBtn: res.pass),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              ContainerMN(textCont: res.note),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 120,
                    height: 120,
                    child: MenuScreen(
                      msg: msg,
                      onMenuChanged: (String val) {
                        debugPrint('val = $val');
                        debugPrint('msg = $msg');
                        // setState(() {

                        menuSet(val);
                        // });
                      },
                    ))),
          ],
        ),
      );
      debugPrint('_initialized');
      debugPrint('_error   $_error');
      debugPrint('_initialized   $_initialized');
    }

    debugPrint('BuildContext');
    debugPrint('_error   $_error');
    debugPrint('_initialized   $_initialized');
    return Text('_XXX');
  }
}

Widget cbWidget(BuildContext context) {
  return Row(
    children: [
      NeumorphicButton(
        margin: EdgeInsets.only(top: 12),
        onPressed: () {},
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
            depth: 2,
            intensity: 0.9,
            surfaceIntensity: 0.9,
            border: NeumorphicBorder(
              color: Colors.grey[400],
              width: 0.8,
            ),
            lightSource: LightSource.topLeft,
            color: Colors.grey[600]),
        padding: const EdgeInsets.all(12.0),
        child: NeumorphicIcon(
          Icons.add_circle,
          size: 22,
        ),
        //  Text(
        //   "Toggle Theme",
        //   style: TextStyle(color: NeumorphicTheme.accentColor(context)),
        // ),
      ),
      SizedBox(
        width: 12,
        height: 50,
      ),
      SizedBox(
        width: 40,
        height: 40,
        child: NeumorphicRadio(
          style: NeumorphicRadioStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              intensity: 0.9,
              selectedDepth: -4,
              unselectedDepth: 2,
              border: NeumorphicBorder(
                color: Colors.grey[400],
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              selectedColor: Colors.blueAccent[600],
              unselectedColor: Colors.grey[400]),
          groupValue: 20,
          value: 2012,
          onChanged: (value) {
            // setState(() {
            //   groupValue = value;
            // });
          },
          child: Center(
            child: NeumorphicIcon(
              Icons.credit_card,
              size: 22,
            ),
          ),
          // Text("2012"),
        ),
      ),
      SizedBox(
        width: 12,
        height: 50,
      ),
      SizedBox(
        width: 40,
        height: 40,
        child: NeumorphicRadio(
          style: NeumorphicRadioStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              intensity: 0.9,
              selectedDepth: -4,
              unselectedDepth: 2,
              border: NeumorphicBorder(
                color: Colors.grey[400],
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              selectedColor: Color.fromARGB(255, 0, 167, 209),
              unselectedColor: Colors.grey[400]),

          groupValue: 2012,
          value: 2012,
          onChanged: (value) {
            // setState(() {
            //   groupValue = value;
            // });
          },
          child: Center(
            child: NeumorphicIcon(
              Icons.password,
              size: 22,
            ),
          ),
          // Text("2012"),
        ),
      ),
    ],
  );
}
