import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/models/local_db/secstor_card.dart';
import 'package:sbox/provider/add_site_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/ui/screens/edit_card.dart';
import 'package:sbox/ui/widgets/button_appbar_backup.dart';
import 'package:sbox/ui/screens/edit_site.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_appbar_card.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';

class CardScreen extends StatefulWidget {
  CardScreen({
    Key? key,
  }) : super(key: key);

  @override
  CardScreenState createState() => CardScreenState();
}

class CardScreenState extends State<CardScreen> {
  bool initialized = false;
  bool error = false;

  final bColor = ColorsSHM();
  String query = '';
  TextEditingController editingController = TextEditingController();

  // @override
  // void dispose() async {
  //   Hive.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // initialized = context.watch<StateProvider>().initialized;
    // error = context.watch<StateProvider>().error;

    if (context.watch<StateProvider>().error) {
      debugPrint('_error');
      debugPrint('_error   $error');
      debugPrint('_initialized   $initialized');

      return LoginScreen(); //Text('error');
    }

    if (context.watch<StateProvider>().initialized) {
      return SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: NeumorphicTheme.baseColor(context),
              appBar: AppBar(
                backgroundColor: NeumorphicTheme.accentColor(context),
                automaticallyImplyLeading: false,

                title: Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    ButtonAppBarCardAdd(iconBtn: Icons.add),
                    Expanded(
                      child: SizedBox(),
                    ),
                    radioWidget(),
                    Expanded(
                      child: SizedBox(),
                    ),
                    ButtonAppBarBackup(iconBtn: Icons.download),
                    Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      width: 90,
                    ),
                  ],
                ),

                //Color: NeumorphicTheme.accentColor(context),
              ),
              body: Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      SearchWgt(context),
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<C_hiveCard>(HiveBoxes.db_hiveCard)
                                .listenable(),
                        builder: (context, Box<C_hiveCard> box, _) {
                          DatabaseProvider databaseProvider =
                              Provider.of<DatabaseProvider>(context,
                                  listen: false);
                          {
                            List<C_hiveCard> results = query.isEmpty
                                ? box.values.toList() // whole list
                                : box.values
                                    .where((c) => c.note
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                    .toList();
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final res = results[index];
                                return Dismissible(
                                  background: Container(
                                    color: Colors.cyan[900],
                                    child: Padding(
                                      padding: const EdgeInsets.all(55),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.edit_note,
                                              color: Colors.white),
                                          Text(LocaleKeys.edit.tr(),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.redAccent[700],
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.delete,
                                              color: Colors.amber),
                                          Text(LocaleKeys.delete.tr(),
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: UniqueKey(),
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    if (direction !=
                                        DismissDirection.startToEnd) {
                                      return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titleTextStyle: TextStyle(
                                                color: _textColor(context)),
                                            contentTextStyle: TextStyle(
                                                color: _textColor(context)),
                                            backgroundColor:
                                                _fillCardColor(context),
                                            title:
                                                Text(LocaleKeys.confirm.tr()),
                                            content:
                                                Text(LocaleKeys.deleteQ.tr()),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: () {
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  databaseProvider
                                                      .updateSelectedCardIndex(
                                                          index);
                                                  databaseProvider
                                                      .deleteFromCardHive();
                                                  //box.delete(index);
                                                  debugPrint('Remove item');
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Colors.white),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(20),
                                                  backgroundColor:
                                                      _fillSelectedColor(
                                                          context), // <-- Button color
                                                  foregroundColor: Colors
                                                      .red, // <-- Splash color
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Icon(Icons.cancel,
                                                    color: Colors.white),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(20),
                                                  backgroundColor:
                                                      _fillSelectedColor(
                                                          context), // <-- Button color
                                                  foregroundColor: Colors
                                                      .red, // <-- Splash color
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => EditCard(
                                                    id: index,
                                                    note: res.note,
                                                    card: res.card,
                                                    name: res.name,
                                                    dateExp: res.dateExp,
                                                    cvv: res.cvv,
                                                    pinAtm: res.pinAtm,
                                                  )));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0,
                                        right: 18.0,
                                        top: 5.0,
                                        bottom: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: _fillCardColor(context),
                                          border: Border.all(
                                            color: _borderColor(context),
                                            width: 2, //width of border
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ButtonMN(
                                                  textBtn: res.card,
                                                  textLbl:
                                                      LocaleKeys.c_card.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ButtonMN(
                                                  textBtn: res.name,
                                                  textLbl:
                                                      LocaleKeys.c_name.tr(),
                                                ),
                                                ButtonMN(
                                                  textBtn: res.cvv,
                                                  textLbl:
                                                      LocaleKeys.c_cvv.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ContainerMN(
                                                  textCont: res.note,
                                                  textLbl:
                                                      LocaleKeys.c_note.tr(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
                child: GestureDetector(
                    onTap: () {
                      context.read<MenuProvider>().changeTap(true);
                      print("Container was tapped");

                      try {
                        context.read<SoundProvider>().playSound('menu');
                      } catch (e) {
                        print("Error loading audio source: $e");
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 3.1, right: 3.1),
                      width: context.watch<MenuProvider>().dataW,
                      height: context.watch<MenuProvider>().dataH,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0.1, bottom: 0.1),
                        padding: const EdgeInsets.only(left: 0.1, bottom: 0.1),
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

      debugPrint('initialized');
      debugPrint('error   $error');
      debugPrint('initialized   $initialized');
    }

    debugPrint('BuildContext');
    debugPrint('_error   $error');
    debugPrint('_initialized   $initialized');
    return
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => LoginScreen()));

        // LoginScreen();

        Text('_XXX');
  }

  @override
  Widget SearchWgt(context) {
    return Container(
        child: SizedBox(
      height: 60,
      child: //Text(''),

          Padding(
        padding:
            const EdgeInsets.only(top: 18, bottom: 1, left: 1, right: 13.0),
        child: Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: 250,
              child: TextField(
                cursorColor: _borderColor(context),
                onChanged: (value) {
                  setState(() {
                    query = value.toLowerCase();
                  });
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
                  labelText: LocaleKeys.c_note.tr(),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: _borderColor(context),
                  ),
                  hintText: LocaleKeys.c_search.tr(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _borderColor(context),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: _borderColor(context),
                    ),
                    onPressed: (() {
                      setState(() {
                        editingController.clear();
                        query = '';
                      });
                    }),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: _borderColor(context), width: 2.0),
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
                        color: _fillSelectedColor(context), width: 2.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
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
