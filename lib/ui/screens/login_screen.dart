import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false; // This is initially false where no loading state

  final bColor = ColorsSHM();

  String _pass = '';

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataLoadFunction();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkNewDb(context));
    debugPrint('checkNewDb');
  }

  dataLoadFunction() async {
    setState(() {
      _isLoading = true; // your loader has started to load
    });
    // fetch you data over here
    setState(() {
      _isLoading = false; // your loder will stop to finish after the data fetch
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: context.watch<ThemeProvider>().topColor,
            body: _isLoading
                ? CircularProgressIndicator() // this will show when loading is true
                : Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        // height: double.infinity,
                        // height: MediaQuery.of(context).size.height / 3,
                        child: RiveAnimation.asset(
                          // fit: BoxFit.contain,
                          // fit: BoxFit.cover,
                          // fit: BoxFit.fill,
                          fit: BoxFit.none,
                          // fit: BoxFit.fitHeight,
                          // fit: BoxFit.fitWidth,
                          // fit: BoxFit.scaleDown,
                          'assets/logo6.riv',
                          onInit: onInit,
                          alignment: Alignment.center,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            //height: 50,
                            decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().butColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 1),
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: context
                                              .watch<ThemeProvider>()
                                              .txtBGColor,
                                        ),
                                        child: Center(
                                          child: //Text(''),

                                              Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                left: 3,
                                                right: 3),
                                            child: Container(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: TextField(
                                                  cursorColor: context
                                                      .watch<ThemeProvider>()
                                                      .borderColor,
                                                  onChanged: (val) async {
                                                    _pass = val;
                                                  },
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .textColor,
                                                  ),
                                                  controller: editingController,
                                                  decoration: InputDecoration(
                                                    labelStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      color: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .borderColor,
                                                    ),
                                                    labelText: LocaleKeys
                                                        .check_m_pass
                                                        .tr(),
                                                    hintStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      color: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .borderColor,
                                                    ),
                                                    hintText:
                                                        LocaleKeys.c_pass.tr(),
                                                    prefixIcon: Icon(
                                                      Icons.lock,
                                                      color: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .borderColor,
                                                    ),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        Icons.clear,
                                                        color: context
                                                            .watch<
                                                                ThemeProvider>()
                                                            .borderColor,
                                                      ),
                                                      onPressed: (() {
                                                        editingController
                                                            .clear();
                                                      }),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .borderColor,
                                                          width: 2.0),
                                                    ),
                                                    // border: OutlineInputBorder(
                                                    //   // borderRadius: BorderRadius.all(
                                                    //   //     Radius.circular(25.0)),
                                                    //   borderSide: BorderSide(
                                                    //       color:
                                                    //           Color.fromARGB(255, 1, 255, 22),
                                                    //       width: 3.0),
                                                    // ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .fillSelectedColor,
                                                          width: 2.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        // try {

                                        context
                                            .read<DatabaseProvider>()
                                            .changeDataLogin(_pass);
                                        debugPrint('ok1');

                                        context
                                            .read<StateProvider>()
                                            .changeErrState(false);
                                        context
                                            .read<StateProvider>()
                                            .changeInit(false);

                                        context
                                            .read<DatabaseProvider>()
                                            .initSecBD(context);
                                        debugPrint('ok2');

                                        //bool loginState = false;
                                        // loginState = await context
                                        //     .read<StateProvider>()
                                        //     .initialized;
                                        debugPrint('ok3');
                                        //debugPrint('loginState $loginState');

                                        if (await context
                                            .read<StateProvider>()
                                            .initialized) {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) => MainScreen()));
                                          debugPrint('loginState OK');
                                          context
                                              .read<DatabaseProvider>()
                                              .checkPassErr = false;
                                        } else {
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //   content: Text(LocaleKeys.pass_err.tr()),
                                          // ));
                                          context
                                              .read<DatabaseProvider>()
                                              .checkPassErr = true;
                                          debugPrint('loginState Err');
                                        }

                                        bool checkPassErr = context
                                            .read<DatabaseProvider>()
                                            .checkPassErr;

                                        if (checkPassErr) {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                titleTextStyle: TextStyle(
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .textColor),
                                                contentTextStyle: TextStyle(
                                                    color: context
                                                        .watch<ThemeProvider>()
                                                        .textColor),
                                                backgroundColor: context
                                                    .watch<ThemeProvider>()
                                                    .fillCardColor,
                                                title: Text(LocaleKeys
                                                    .check_m_pass
                                                    .tr()),
                                                content: Text(LocaleKeys
                                                    .err_old_pass
                                                    .tr()),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              DatabaseProvider>()
                                                          .checkPassErr;
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Icon(Icons.done,
                                                        color: Colors.white),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(),
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      backgroundColor: context
                                                          .watch<
                                                              ThemeProvider>()
                                                          .txtBGColor, // <-- Button color
                                                      //foregroundColor: _txtBGColor(context),// <-- Splash color
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          );

                                          debugPrint('check_PassErr');
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: context
                                              .watch<ThemeProvider>()
                                              .txtBGColor,
                                        ),
                                        child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.login,
                                                size: 35,
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .textColor,
                                              )
                                              //  Text(
                                              //   ' Log In',
                                              //   style: TextStyle(
                                              //     color: _txtColor(context),
                                              //     fontSize: 30,
                                              //     fontWeight: FontWeight.w500,
                                              //   ),
                                              // ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
          Align(
              alignment: Alignment.topRight,

              //alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    context.read<MenuProvider>().changeTap(true);
                    context.read<SoundProvider>().playSound('menu');
                    print("Container was tapped");
                  },
                  child: Container(
                    // margin: const EdgeInsets.only(left: 0.1, bottom: 0.1),
                    padding: const EdgeInsets.only(top: 3.1, right: 3.1),

                    // child: Transform.scale(
                    // scale: 1.0,
                    //constraints: BoxConstraints.loose(Size(50, 50)),
                    //constraints: BoxConstraints(minWidth: 50, maxWidth: 150),
                    // maxWidth: 50,
                    // maxHeight: 50,
                    // alignment: Alignment.topRight,

                    // width: 54,
                    // height: 53,
                    // width: 125,
                    // height: 125,
                    width: context.watch<MenuProvider>().dataW,
                    height: context.watch<MenuProvider>().dataH,

                    // //scale: 0.8,
                    // minWidth: 45.0,
                    // minHeight: 100.0,
                    //maxWidth: 70.0,
                    // maxHeight: 60.0,

                    // minWidth: 0.0,
                    // minHeight: 0.0,
                    // maxWidth: double.infinity,
                    // maxHeight: double.infinity,

                    child: Container(
                      margin: const EdgeInsets.only(left: 0.1, bottom: 0.1),
                      padding: const EdgeInsets.only(left: 0.1, bottom: 0.1),
                      // width: 120,
                      // height: 120,
                      // alignment: Alignment.topRight,
                      // padding: const EdgeInsets.only(left: 50.0, bottom: 50.0),
                      // constraints: BoxConstraints.tight(Size(50, 50)),
                      // margin: const EdgeInsets.only(left: 50.0, bottom: 50.0),
                      // constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
                      // alignment: Alignment.bottomLeft,
                      child: MenuScreen(
                        msg: context.watch<MenuProvider>().msg,
                        // onMenuChanged: (String val) {
                        //   debugPrint('val = $val');
                        //   context.read<MenuProvider>().menuSet(val, context);
                        // },
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Future<void> checkNewDb(BuildContext context) async {
    bool check_db = await context.read<DatabaseProvider>().dbFilesExists();

    bool msg_check_db = await context.read<DatabaseProvider>().msgFilesExist;

    if ((!check_db) && (!msg_check_db)) {
      context.read<DatabaseProvider>().msgdbFilesExists(true);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            titleTextStyle:
                TextStyle(color: context.watch<ThemeProvider>().textColor),
            contentTextStyle:
                TextStyle(color: context.watch<ThemeProvider>().textColor),
            backgroundColor: context.watch<ThemeProvider>().fillCardColor,
            title: Text(LocaleKeys.check_m_pass.tr()),
            content: Text(LocaleKeys.set_new_pass.tr()),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Icon(Icons.done, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  padding: EdgeInsets.all(20),
                  backgroundColor: context
                      .watch<ThemeProvider>()
                      .txtBGColor, // <-- Button color
                  //foregroundColor: _txtBGColor(context),// <-- Splash color
                ),
              )
            ],
          );
        },
      );

      debugPrint('check_dbFilesNO');
    } else {
      debugPrint('check_dbFilesOK');
    }
  }

  void onInit(Artboard artboard) async {
    var controller = StateMachineController.fromArtboard(
      artboard,
      'SM2',
      //onStateChange: onStateChange,
    ) as StateMachineController;
    controller.isActive = true;

    artboard.addController(controller);
  }
}
