import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/provider/db_provider.dart';
import 'package:sbox/models/local_db/provider/menu_provider.dart';
import 'package:sbox/models/local_db/provider/state_provider.dart';
import 'package:sbox/ui/screens/main_screen.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';

class LoginScreen extends StatelessWidget {
  final bColor = ColorsSHM();
  String _pass = '';

  @override
  Widget build(BuildContext context) {
    // Define an async function to initialize FlutterFire

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: _topColor(context),
            body: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
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
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
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
                          children: [
                            const SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _txtBGColor(context),
                              ),
                              child: TextField(
                                onChanged: (val) {
                                  _pass = val;
                                },
                                style: TextStyle(
                                  color: _txtColor(context),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: _txtColor(context),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: _txtColor(context),
                                  ),
                                ),
                              ),
                            ),
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
                                context.read<StateProvider>().changeInit(false);

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
                                  borderRadius: BorderRadius.circular(30),
                                  color: _txtBGColor(context),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      ' Log In',
                                      style: TextStyle(
                                        color: _txtColor(context),
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 35),
                          ],
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
}
