import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/client/hive_names.dart';
import 'package:sbox/models/translat_locale_keys.g.dart';
import 'package:sbox/models/secstor.dart';
import 'package:sbox/models/theme.dart';
import 'package:sbox/screens/add/add_site.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:rive/rive.dart';

import 'package:sbox/client/menu_exe.dart';

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
    return AdaptiveTheme(
      light: kLightTheme,
      dark: kDarkTheme,
      initial: AdaptiveThemeMode.system,
      //initial: AdaptiveThemeMode.dark,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        title: 'Secret Box',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: MainScreen(title: 'Secret Box'),
        debugShowCheckedModeBanner: false,
      ),
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
  late StateMachineController _controller;
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
  String message = '';

  void _onInit(Artboard artboard) {
    var ctrl = StateMachineController.fromArtboard(
      artboard,
      'SM1',
      onStateChange: _onStateChange,
    ) as StateMachineController;
    // ctrl.isActive = true;

    artboard.addController(ctrl);
    //_bump = _controller.findInput<bool>('in_b0') as SMIBool;
    ctrl.findInput<bool>('in_b2-1')!.value = true;
    ctrl.findInput<bool>('in_b2-3')!.value = true;
    ctrl.findInput<bool>('in_b2-5')!.value = true;

    setState(() {
      _controller = ctrl;
    });
  }

  void _onStateChange(
    String stateMachineName,
    String stateName,
  ) =>
      setState(() => {
            message = 'State Changed in $stateMachineName to $stateName',
            print(message),

            _b0Temp = _controller.findInput<bool>('in_b0') as SMIBool,
            _b11Temp = _controller.findInput<bool>('in_b1-1') as SMIBool,
            _b12Temp = _controller.findInput<bool>('in_b1-2') as SMIBool,
            _b13Temp = _controller.findInput<bool>('in_b1-3') as SMIBool,

            _b21Temp = _controller.findInput<bool>('in_b2-1') as SMIBool,
            _b221Temp = _controller.findInput<bool>('in_b2-2_1') as SMIBool,
            _b23Temp = _controller.findInput<bool>('in_b2-3') as SMIBool,
            _b242Temp = _controller.findInput<bool>('in_b2-4_2') as SMIBool,
            _b25Temp = _controller.findInput<bool>('in_b2-5') as SMIBool,
            _b222Temp = _controller.findInput<bool>('in_b2-2_2') as SMIBool,
            _b243Temp = _controller.findInput<bool>('in_b2-4_3') as SMIBool,

            message = _b0Temp!.value.toString(),
            message += ':  1-1:',
            message += _b11Temp!.value.toString(),
            message += ' 1-2:',
            message += _b12Temp!.value.toString(),
            message += ' 1-3:',
            message += _b13Temp!.value.toString(),
            message += ' 2-1:',
            message += _b21Temp!.value.toString(),
            message += ' 2-2_1:',
            message += _b221Temp!.value.toString(),
            message += ' 2-2_2:',
            message += _b222Temp!.value.toString(),
            message += ' 2-3:',
            message += _b23Temp!.value.toString(),
            message += ' 2-4_2:',
            message += _b242Temp!.value.toString(),
            message += ' 2-4_3:',
            message += _b243Temp!.value.toString(),
            message += ' 2-5:',
            message += _b25Temp!.value.toString(),

            print(message),

            if ((_b25Temp!.value == true) && (_b243Temp!.value == false))
              {
                AdaptiveTheme.of(context).setDark(),
              }
            else
              {
                AdaptiveTheme.of(context).setLight(),
              },

            if (_b23Temp!.value == true)
              {
                context.setLocale(Locale('en')),
              },
            if (_b222Temp!.value == true)
              {
                context.setLocale(Locale('ru')),
              },
            if (_b242Temp!.value == true)
              {
                context.setLocale(Locale('ru')),
              },

            //print(_controller.findInput<bool>('in_b0') as SMIBool),
            //print(_controller.findInput<bool>('in_b0') as String),

            //_controller.findInput<bool>('in_b0')!.value = false,
          });
//open menu
  void _hitBump() {
    if (_controller.findInput<bool>('in_b0')!.value == true) {
      _controller.findInput<bool>('in_b0')!.value = false;
    } else {
      _controller.findInput<bool>('in_b0')!.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Stack(children: [
        Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(widget.title),
                IconButton(
                  icon: Icon(Icons.language),
                  onPressed: () {
                    if (context.locale == Locale('ru')) {
                      context.setLocale(Locale('en'));
                    } else {
                      context.setLocale(Locale('ru'));
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.sunny),
                  onPressed: () {
                    if (AdaptiveTheme.of(context).mode.isLight) {
                      // sets theme mode to dark
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      // sets theme mode to light
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                ),
                Spacer(),
              ],
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
                    background:
                        Container(color: Color.fromARGB(255, 158, 54, 244)),
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
                .push(MaterialPageRoute(builder: (context) => AddSite())),
            tooltip: LocaleKeys.Add.tr(),
            child: Icon(Icons.add),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 120,
            height: 120,
            child: RiveAnimation.asset(
              'assets/menu2.riv',
              onInit: _onInit,
            ),
          ),
        ),
      ]),
    );
  }
}
