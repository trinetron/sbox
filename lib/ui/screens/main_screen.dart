import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/hive_setting.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/add_edit_site_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/ui/widgets/button_appbar_backup.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_nm_pass_site.dart';
import 'package:sbox/ui/widgets/button_nm_www.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';
import 'package:sbox/ui/widgets/top_body_text.dart';

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

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: context.watch<ThemeProvider>().baseColor,
              appBar: AppBar(
                backgroundColor: context.watch<ThemeProvider>().accentColor,
                automaticallyImplyLeading: false,
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
                    ButtonAppBarBackup(iconBtn: Icons.download),
                    Expanded(
                      child: SizedBox(),
                    ),
                    IconButton(
                      iconSize: 20,
                      splashRadius: 20,
                      icon: Icon(
                        (context.watch<PermissionsService>().showPassword)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.watch<ThemeProvider>().textColor,
                      ),
                      onPressed: () {
                        context.read<PermissionsService>().togglevisibility();
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              body: Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      TopBodyText(textLbl: LocaleKeys.confirm.tr()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //>>>
                          Container(
                            child: SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 18, bottom: 1, left: 1, right: 13.0),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: TextField(
                                        cursorColor: context
                                            .watch<ThemeProvider>()
                                            .borderColor,
                                        onChanged: (value) {
                                          setState(() {
                                            query = value.toLowerCase();
                                          });
                                        },
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: context
                                              .watch<ThemeProvider>()
                                              .textColor,
                                        ),
                                        controller: editingController,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            fontSize: 18.0,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .borderColor,
                                          ),
                                          labelText: LocaleKeys.c_note.tr(),
                                          hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .textColor,
                                          ),
                                          hintText:
                                              '  ' + LocaleKeys.c_search.tr(),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: context
                                                .watch<ThemeProvider>()
                                                .textColor,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                              color: context
                                                  .watch<ThemeProvider>()
                                                  .borderColor,
                                            ),
                                            onPressed: (() {
                                              setState(() {
                                                editingController.clear();
                                                query = '';
                                              });
                                            }),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .borderColor,
                                                width: 2.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: context
                                                    .watch<ThemeProvider>()
                                                    .fillSelectedColor,
                                                width: 2.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //>>>
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<C_hive>(HiveBoxes.db_hive).listenable(),
                        builder: (context, Box<C_hive> box, _) {
                          DatabaseProvider databaseProvider =
                              Provider.of<DatabaseProvider>(context,
                                  listen: false);

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
                                            title:
                                                Text(LocaleKeys.confirm.tr()),
                                            content:
                                                Text(LocaleKeys.deleteQ.tr()),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                onPressed: () {
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  databaseProvider
                                                      .updateSelectedIndex(
                                                          index);
                                                  databaseProvider
                                                      .deleteFromHive();
                                                  //box.delete(index);
                                                  debugPrint('Remove item');
                                                  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                                  Navigator.of(context)
                                                      .pop(true);
                                                },
                                                child: Icon(Icons.delete,
                                                    color: Colors.white),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      RoundedRectangleBorder(),
                                                  padding: EdgeInsets.all(20),
                                                  backgroundColor: context
                                                      .watch<ThemeProvider>()
                                                      .fillSelectedColor, // <-- Button color
                                                  foregroundColor: Colors
                                                      .red, // <-- Splash color
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Icon(Icons.cancel,
                                                    color: Colors.white),
                                                style: ElevatedButton.styleFrom(
                                                  shape:
                                                      RoundedRectangleBorder(),
                                                  padding: EdgeInsets.all(20),
                                                  backgroundColor: context
                                                      .watch<ThemeProvider>()
                                                      .fillSelectedColor, // <-- Button color
                                                  foregroundColor: Colors
                                                      .red, // <-- Splash color
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      context
                                          .read<AddSiteProvider>()
                                          .cleanDataText();

                                      context
                                          .read<AddSiteProvider>()
                                          .changeDataText(res.login, 2);
                                      context
                                          .read<AddSiteProvider>()
                                          .changeDataText(res.task, 1);
                                      context
                                          .read<AddSiteProvider>()
                                          .changeDataText(res.pass, 3);
                                      context
                                          .read<AddSiteProvider>()
                                          .changeDataText(res.note, 4);

                                      context
                                          .read<AddSiteProvider>()
                                          .changeFlgAddSite(false);
                                      context
                                          .read<AddSiteProvider>()
                                          .changeDataId(index);

                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (context, a1, a2) =>
                                                  AddSite()));

                                      // Navigator.of(context).push(
                                      //     PageRouteBuilder(
                                      //         pageBuilder: (context, a1, a2) =>
                                      //             EditSite(
                                      //               id: index,
                                      //               task: res.task,
                                      //               login: res.login,
                                      //               pass: res.pass,
                                      //               note: res.note,
                                      //             )));
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
                                          color: context
                                              .watch<ThemeProvider>()
                                              .fillCardColor,
                                          border: Border.all(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .borderColor,
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
                                                ButtonMNwww(
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
                                                  flx: 1,
                                                ),
                                                ButtonMN_PassSite(
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

                      width: context.watch<MenuProvider>().dataW,
                      height: context.watch<MenuProvider>().dataH,

                      child: Container(
                        margin: const EdgeInsets.only(left: 0.1, bottom: 0.1),
                        padding: const EdgeInsets.only(left: 0.1, bottom: 0.1),
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

    debugPrint('BuildContext');
    debugPrint('_error   $error');
    debugPrint('_initialized   $initialized');
    return const Text('_XXX');
  }

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
                cursorColor:
                    Colors.black, //context.watch<ThemeProvider>().borderColor,
                onChanged: (value) {
                  setState(() {
                    query = value.toLowerCase();
                  });
                },
                style: TextStyle(
                  fontSize: 15.0,
                  color:
                      Colors.black, //context.watch<ThemeProvider>().textColor,
                ),
                controller: editingController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors
                        .black, //context.watch<ThemeProvider>().borderColor,
                  ),
                  labelText: LocaleKeys.c_note.tr(),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors
                        .black, //context.watch<ThemeProvider>().borderColor,
                  ),
                  hintText: '  ' + LocaleKeys.c_search.tr(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors
                        .black, //context.watch<ThemeProvider>().borderColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors
                          .black, //context.watch<ThemeProvider>().borderColor,
                    ),
                    onPressed: (() {
                      setState(() {
                        editingController.clear();
                        query = '';
                      });
                    }),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .black, //context.watch<ThemeProvider>().borderColor,
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
                        color: Colors
                            .black, //context.watch<ThemeProvider>().fillSelectedColor,
                        width: 2.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
