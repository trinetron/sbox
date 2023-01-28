import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';

class LoginScreen extends StatelessWidget {
  final bColor = ColorsSHM();
  String _pass = '';
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: _topColor(context),
            body: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Container(
                  width: 50,
                  // height: double.infinity,
                  // height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset('assets/images/flutter.png'),
                ),
                Expanded(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      //height: 50,
                      decoration: BoxDecoration(
                        color: _butColor(context),
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
                              const SizedBox(height: 5),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: _txtBGColor(context),
                                  ),
                                  child: Center(
                                    child: //Text(''),

                                        Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 4, left: 3, right: 3),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: TextField(
                                            cursorColor: _borderColor(context),
                                            onChanged: (val) async {
                                              _pass = val;

                                              bool check_db = await context
                                                  .read<DatabaseProvider>()
                                                  .dbFilesExists();

                                              bool msg_check_db = await context
                                                  .read<DatabaseProvider>()
                                                  .msgFilesExist;

                                              if ((!check_db) &&
                                                  (!msg_check_db)) {
                                                context
                                                    .read<DatabaseProvider>()
                                                    .msgdbFilesExists(true);
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(LocaleKeys
                                                          .check_m_pass
                                                          .tr()),
                                                      content: Text(LocaleKeys
                                                          .set_new_pass
                                                          .tr()),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          child: Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                CircleBorder(),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    20),
                                                            backgroundColor:
                                                                _txtBGColor(
                                                                    context), // <-- Button color
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
                                            },
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: _textColor(context),
                                            ),
                                            controller: editingController,
                                            decoration: InputDecoration(
                                              labelStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: _borderColor(context),
                                              ),
                                              labelText:
                                                  LocaleKeys.check_m_pass.tr(),
                                              hintStyle: TextStyle(
                                                fontSize: 15.0,
                                                color: _borderColor(context),
                                              ),
                                              hintText: LocaleKeys.c_pass.tr(),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: _borderColor(context),
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: _borderColor(context),
                                                ),
                                                onPressed: (() {
                                                  editingController.clear();
                                                }),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        _borderColor(context),
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
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _fillSelectedColor(
                                                        context),
                                                    width: 2.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 35),
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
                                  } else {
                                    // ScaffoldMessenger.of(context)
                                    //     .showSnackBar(SnackBar(
                                    //   content: Text(LocaleKeys.pass_err.tr()),
                                    // ));
                                  }

                                  //   debugPrint('pass check try run: ---');
                                  // } catch (e) {
                                  //   debugPrint('pass check error caught: $e');

                                  //   debugPrint('err run: ---');
                                  // }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: _txtBGColor(context),
                                  ),
                                  child: Center(
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.login,
                                          size: 35,
                                          color: _textColor(context),
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
                              const SizedBox(height: 15),
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
                        onMenuChanged: (String val) {
                          debugPrint('val = $val');
                          context.read<MenuProvider>().menuSet(val, context);
                        },
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Color _txtColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color _txtBGColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.baseColorL;
    } else {
      return bColor.baseColorD;
    }
  }

  Color _butColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.accentColorL;
    } else {
      return bColor.accentColorD;
    }
  }

  Color _topColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.appBarColorL;
    } else {
      return bColor.appBarColorD;
    }
  }

  Color _textColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color _fillColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.buttonFillL;
    } else {
      return bColor.buttonFillD;
    }
  }

  Color _fillSelectedColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.radioFillL;
    } else {
      return bColor.radioFillD;
    }
  }

  Color _borderColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.borderL;
    } else {
      return bColor.borderD;
    }
  }

  Color _fillCardColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.cardColorL;
    } else {
      return bColor.cardColorD;
    }
  }
}
