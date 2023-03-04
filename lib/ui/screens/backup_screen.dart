import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:hive/hive.dart';
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
import 'package:sbox/ui/screens/edit_site.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_appbar_backup.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';
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
            backgroundColor: NeumorphicTheme.baseColor(context),
            appBar: AppBar(
              backgroundColor: NeumorphicTheme.accentColor(context),
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
                    TopBodyText(textLbl: LocaleKeys.confirm.tr()),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, top: 4.0, bottom: 4.0),
                      child: NeumorphicButton(
                        margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        onPressed: () {
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
                              color: _borderColor(context),
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: _fillColor(context)),
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
                                      fontSize: 12, color: _textColor(context)),
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
                          context
                              .read<DatabaseProvider>()
                              .restoreDbFile(context);
                        },
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(2)),
                            depth: 2,
                            intensity: 0.9,
                            surfaceIntensity: 0.9,
                            border: NeumorphicBorder(
                              color: _borderColor(context),
                              width: 0.8,
                            ),
                            lightSource: LightSource.topLeft,
                            color: _fillColor(context)),
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
                                      fontSize: 12, color: _textColor(context)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
