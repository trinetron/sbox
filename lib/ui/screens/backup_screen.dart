import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';

import 'package:sbox/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/add_edit_site_screen.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_appbar_backup.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';
import 'package:sbox/ui/widgets/text_field_master_pass.dart';
import 'package:sbox/ui/widgets/top_body_text.dart';

class BackupScreen extends StatefulWidget {
  BackupScreen({
    Key? key,
  }) : super(key: key);

  @override
  BackupScreenState createState() => BackupScreenState();
}

class BackupScreenState extends State<BackupScreen> {
  bool initialized = false;
  bool error = false;

  final bColor = ColorsSHM();
  String query = '';
  TextEditingController editingController = TextEditingController();

  // List<String> listFiles = [
  //   'sec_box.hive',
  //   // 'sec_box.lock',
  //   'sec_box_card.hive',
  //   //'sec_box_card.lock',
  //   'setbox.hive',
  //   // 'setbox.lock'
  // ];

  @override
  Widget build(BuildContext context) {
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
                    TopBodyText(textLbl: LocaleKeys.optin_lbl.tr()),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 4.0, bottom: 4.0),
                      child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        onPressed: () {
                          context.read<SoundProvider>().playSound('save');
                          context
                              .read<DatabaseProvider>()
                              .backupDbFile(context);
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2)),
                            depth: 2,
                            intensity: 0.9,
                            surfaceIntensity: 0.9,
                            border: NeumorphicBorder(
                              color: context.watch<ThemeProvider>().borderColor,
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: context.watch<ThemeProvider>().fillColor),
                        // style: NeumorphicStyle(
                        //   shape: NeumorphicShape.flat,
                        //   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                        //   color: _iconsColor(context),
                        // ),
                        padding: const EdgeInsets.fromLTRB(
                          6.0,
                          3.0,
                          0,
                          0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                8.0,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.save_back.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 4.0, bottom: 4.0),
                      child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        onPressed: () async {
                          context.read<SoundProvider>().playSound('err');
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
                                title: Text(LocaleKeys.confirm.tr()),
                                content: Text(LocaleKeys.r_backup_dec.tr()),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<DatabaseProvider>()
                                          .restoreDbFile(context);
                                      //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Icon(Icons.download_done,
                                        color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: context
                                          .watch<ThemeProvider>()
                                          .fillSelectedColor, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child:
                                        Icon(Icons.cancel, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: context
                                          .watch<ThemeProvider>()
                                          .fillSelectedColor, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },

                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2)),
                            depth: 2,
                            intensity: 0.9,
                            surfaceIntensity: 0.9,
                            border: NeumorphicBorder(
                              color: context.watch<ThemeProvider>().borderColor,
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: context.watch<ThemeProvider>().fillColor),
                        // style: NeumorphicStyle(
                        //   shape: NeumorphicShape.flat,
                        //   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                        //   color: _iconsColor(context),
                        // ),
                        padding: const EdgeInsets.fromLTRB(
                          6.0,
                          3.0,
                          0,
                          0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                8.0,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.load_back.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //>>>
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 4.0, bottom: 4.0),
                      child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        onPressed: () async {
                          context.read<SoundProvider>().playSound('err');
                          _showModalChangeMasterPass(context);
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2)),
                            depth: 2,
                            intensity: 0.9,
                            surfaceIntensity: 0.9,
                            border: NeumorphicBorder(
                              color: context.watch<ThemeProvider>().borderColor,
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: context.watch<ThemeProvider>().fillColor),
                        padding: const EdgeInsets.fromLTRB(
                          6.0,
                          3.0,
                          0,
                          0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                8.0,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.chng_mass_pass.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 4.0, bottom: 4.0),
                      child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        onPressed: () async {
                          context.read<SoundProvider>().playSound('err');
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
                                title: Text(LocaleKeys.confirm.tr()),
                                content: Text(LocaleKeys.csv_dec.tr()),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      context
                                          .read<SoundProvider>()
                                          .playSound('save');
                                      context
                                          .read<DatabaseProvider>()
                                          .generateCsvFiles();
                                      debugPrint('generateCsvFiles items');
                                      //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Icon(Icons.select_all_rounded,
                                        color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: context
                                          .watch<ThemeProvider>()
                                          .fillSelectedColor, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child:
                                        Icon(Icons.cancel, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(),
                                      padding: EdgeInsets.all(20),
                                      backgroundColor: context
                                          .watch<ThemeProvider>()
                                          .fillSelectedColor, // <-- Button color
                                      foregroundColor:
                                          Colors.red, // <-- Splash color
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2)),
                            depth: 2,
                            intensity: 0.9,
                            surfaceIntensity: 0.9,
                            border: NeumorphicBorder(
                              color: context.watch<ThemeProvider>().borderColor,
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: context.watch<ThemeProvider>().fillColor),
                        // style: NeumorphicStyle(
                        //   shape: NeumorphicShape.flat,
                        //   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                        //   color: _iconsColor(context),
                        // ),
                        padding: const EdgeInsets.fromLTRB(
                          6.0,
                          3.0,
                          0,
                          0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                8.0,
                                8.0,
                                8.0,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  LocaleKeys.dload_db_csv.tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: context
                                          .watch<ThemeProvider>()
                                          .textColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //>>>
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

  //>>>>>>>>>>>>>>>>>>

  _showModalChangeMasterPass(BuildContext context) {
    double lowVal = 30;
    double highVal = 70;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titleTextStyle:
              TextStyle(color: context.watch<ThemeProvider>().textColor),
          contentTextStyle:
              TextStyle(color: context.watch<ThemeProvider>().textColor),
          backgroundColor: context.watch<ThemeProvider>().fillColor,
          title: Text(LocaleKeys.chng_mass_pass.tr()),
          content: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(LocaleKeys.set_new_pass.tr()),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   context.watch<AddSiteProvider>().lengthVol.toString(),
                    //   style: TextStyle(
                    //     color: context.watch<ThemeProvider>().textColor,
                    //   ),
                    // ),
                    TextFieldMasterPass(
                      textLbl: LocaleKeys.mass_pass_lbl.tr(),
                    ),
                  ],
                ),

                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                context.read<SoundProvider>().playSound('save');
                context.read<DatabaseProvider>().changeMasterPass();
                // editingController.text =
                //     await context.read<AddSiteProvider>().genPassVol;

                Navigator.of(context).pop(true);
              },
              child: Icon(Icons.new_releases_outlined, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: context
                    .watch<ThemeProvider>()
                    .fillSelectedColor, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Icon(Icons.cancel, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: context
                    .watch<ThemeProvider>()
                    .fillSelectedColor, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
            ),
          ],
        );
      },
    );
  }
}
