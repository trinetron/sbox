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
import 'package:sbox/provider/add_card_provider.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:sbox/provider/menu_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/state_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/add_edit_card_screen.dart';
import 'package:sbox/ui/widgets/button_appbar_backup.dart';
import 'package:sbox/ui/screens/login_screen.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_appbar_card.dart';
import 'package:sbox/ui/widgets/button_nm_card_num.dart';
import 'package:sbox/ui/widgets/button_nm_pass_site.dart';
import 'package:sbox/ui/widgets/radio_nm.dart';
import 'package:sbox/ui/widgets/menu_setting.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/container_nm.dart';
import 'package:sbox/ui/widgets/top_body_text.dart';

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
              backgroundColor: context.watch<ThemeProvider>().baseColor,
              appBar: AppBar(
                backgroundColor: context.watch<ThemeProvider>().accentColor,
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

                //Color: NeumorphicTheme.accentColor(context),
              ),
              body: Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      TopBodyText(textLbl: LocaleKeys.cards_lbl.tr()),
                      //>>>>>
                      Container(
                        child: SizedBox(
                          height: 60,
                          child: //Text(''),

                              Padding(
                            padding: const EdgeInsets.only(
                                top: 18, bottom: 1, left: 1, right: 13.0),
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
                                    hintText: '  ' + LocaleKeys.c_search.tr(),
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
                      //>>>>>
                      //SearchWgt(context),
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
                                          .read<AddCardProvider>()
                                          .changeDataText(res.note, 1);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.card, 2);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.name, 3);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.date, 4);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.dateExp, 5);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.cvv, 6);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataText(res.pinAtm, 7);
                                      context
                                          .read<AddCardProvider>()
                                          .changeDataId(index);

                                      context
                                          .read<AddCardProvider>()
                                          .changeFlgAddCard(false);

                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (context, a1, a2) =>
                                                  AddCard()));
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
                                            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                IconButton(
                                                  iconSize: 25,
                                                  color: context
                                                      .watch<ThemeProvider>()
                                                      .textColor,
                                                  icon: const Icon(
                                                      Icons.credit_card),
                                                  onPressed: () {
                                                    // ...
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                ContainerMN(
                                                  textCont: res.note,
                                                  textLbl:
                                                      LocaleKeys.c_note.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ButtonMN_CardNum(
                                                  textBtn: res.card,
                                                  textLbl:
                                                      LocaleKeys.c_card.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ButtonMN(
                                                  textBtn: res.date,
                                                  textLbl:
                                                      LocaleKeys.c_date.tr(),
                                                  flx: 1,
                                                ),
                                                ButtonMN(
                                                  textBtn: res.dateExp,
                                                  textLbl: LocaleKeys.c_date_exp
                                                      .tr(),
                                                  flx: 1,
                                                ),
                                                ButtonMN_PassSite(
                                                  textBtn: res.pinAtm,
                                                  textLbl:
                                                      LocaleKeys.c_pin.tr(),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                ButtonMN(
                                                  textBtn: res.name,
                                                  textLbl:
                                                      LocaleKeys.c_name.tr(),
                                                  flx: 3,
                                                ),
                                                ButtonMN_PassSite(
                                                  textBtn: res.cvv,
                                                  textLbl:
                                                      LocaleKeys.c_cvv.tr(),
                                                ),
                                              ],
                                            ),
                                            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
}
