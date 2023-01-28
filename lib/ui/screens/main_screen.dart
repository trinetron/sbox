import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/add_site_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/ui/screens/add_site.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/ui/screens/edit_site.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';

//>>>>>>>>>>>>>>>>>>
//import 'package:just_audio/just_audio.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';

//part 'package:sbox/ui/widgets/app_bar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool initialized = false;
  bool error = false;

  final bColor = ColorsSHM();
  String query = '';
  TextEditingController editingController = TextEditingController();

// late Box boxA;

  //final hiveSetting = HiveSetting();

  //late var results;

  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

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
                // leading:
                // FloatingActionButton(
                //   onPressed: () => {
                //     Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => AddSite())),
                //   },
                //   tooltip: LocaleKeys.Add.tr(),
                //   child: Icon(Icons.add),
                // ),

                //     NeumorphicButton(
                //   margin: EdgeInsets.only(top: 12),
                //   onPressed: () => {
                //     Navigator.of(context).push(
                //         MaterialPageRoute(builder: (context) => AddSite())),
                //   },
                //   style: NeumorphicStyle(
                //       shape: NeumorphicShape.flat,
                //       boxShape: NeumorphicBoxShape.roundRect(
                //           BorderRadius.circular(5)),
                //       depth: 2,
                //       intensity: 0.9,
                //       surfaceIntensity: 0.9,
                //       border: NeumorphicBorder(
                //         color: Colors.grey[400],
                //         width: 0.8,
                //       ),
                //       lightSource: LightSource.topLeft,
                //       color: Colors.grey[600]),

                //   padding: const EdgeInsets.all(12.0),
                //   child: NeumorphicIcon(
                //     Icons.add_circle,
                //     size: 22,
                //   ),
                //   //  Text(
                //   //   "Toggle Theme",
                //   //   style: TextStyle(color: NeumorphicTheme.accentColor(context)),
                //   // ),
                // ),

                title: Row(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    ButtonAppBarAdd(iconBtn: Icons.add),
                    Expanded(
                      child: SizedBox(),
                    ),
                    radioWidget(),
                    Expanded(
                      child: SizedBox(),
                    ),
                    ButtonAppBarAdd(iconBtn: Icons.download),
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
                            List<C_hive> results = query.isEmpty
                                ? box.values.toList() // whole list
                                : box.values
                                    .where((c) => c.note
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                    .toList()
                              ..where((c) => c.task
                                  .toLowerCase()
                                  .contains(query.toLowerCase())).toList();

                            //   List<C_hive> results2 = query.isEmpty

                            // if (query != '') {
                            //   List<C_hive> results2 = query.isEmpty
                            //       ? box.values.toList() // whole list
                            //       : box.values
                            //           .where((c) =>
                            //               c.task.toLowerCase().contains(query))
                            //           .toList();

                            //   results.forEach((c) {
                            //     //bool coli = results2.any((e) => e.id != id);
                            //    // if (coli) {
                            //       results = results + results2.elementAt(context);
                            //    // }
                            //   });

                            // if (results2.any((c) =>
                            //     c.id !=
                            //     results.where((e) =>
                            //         c.note.toLowerCase().contains(query)))) {
                            //   results2 = results2 +
                            //       results
                            //           .where((e) => e.note
                            //               .toLowerCase()
                            //               .contains(query))
                            //           .toList();
                            // }
                            // }

                            // var resultsAll = results + results2;

                            // late List<C_hive> results = box.values.toList();

                            // if (query.isEmpty) {
                            //   box.values.toList();
                            // } else {
                            //   results = box.values
                            //       .where((c) =>
                            //           c.task.toLowerCase().contains(query))
                            //       .toList();
                            //   results = box.values
                            //       .where((c) =>
                            //           c.note.toLowerCase().contains(query))
                            //       .toList();

                            // results.addAll(box.values
                            //     .where((c) =>
                            //         c.note.toLowerCase().contains(query))
                            //     .toList());
                            //}
                            // (box.values
                            // .where((c) => c.note.toLowerCase().contains(query))
                            // .toList()));

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
                                      padding: const EdgeInsets.all(15),
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
                                            title:
                                                Text(LocaleKeys.confirm.tr()),
                                            content:
                                                Text(LocaleKeys.deleteQ.tr()),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: () {
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  // databaseProvider
                                                  //     .updateSelectedIndex(
                                                  //         index);
                                                  // databaseProvider
                                                  //     .deleteFromHive();
                                                  // //box.delete(index);
                                                  // debugPrint('Remove item');
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Colors.white),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(20),
                                                  backgroundColor: Colors
                                                      .blue, // <-- Button color
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
                                                  backgroundColor: Colors
                                                      .blue, // <-- Button color
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
                                              builder: (context) => EditSite(
                                                    id: index,
                                                    task: res.task,
                                                    login: res.login,
                                                    pass: res.pass,
                                                    note: res.note,
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
                                                  textBtn: res.task,
                                                  textLbl:
                                                      LocaleKeys.c_site.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ButtonMN(
                                                  textBtn: res.login,
                                                  textLbl:
                                                      LocaleKeys.c_login.tr(),
                                                ),
                                                ButtonMN(
                                                  textBtn: res.pass,
                                                  textLbl:
                                                      LocaleKeys.c_pass.tr(),
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

                //alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {
                      context.read<MenuProvider>().changeTap(true);
                      print("Container was tapped");
                      // AudioPlayer player = AudioPlayer();
                      try {
                        // player.setSourceAsset('audio/chpok.mp3');
                        //player.setReleaseMode(ReleaseMode.release);
                        //player.resume();

                        context.read<SoundProvider>().playSound('menu');
                      } catch (e) {
                        print("Error loading audio source: $e");
                      }
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
