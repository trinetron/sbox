import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_form_add.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/button_past_site.dart';
import 'package:sbox/ui/widgets/button_question_site.dart';
import 'package:sbox/ui/widgets/radio_button_nm.dart';
import 'dart:math';

import 'package:sbox/ui/widgets/text_field_site.dart';
import 'package:sbox/ui/widgets/top_body_text.dart';

@immutable
class AddSite extends StatefulWidget {
  @override
  State<AddSite> createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final bColor = ColorsSHM();

  late String task;

  late String note;

  late String login;

  late String pass;

  final _formKey = GlobalKey<FormState>();

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeProvider>().baseColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
                child: Column(
                  children: [
                    TopBodyText(textLbl: LocaleKeys.cr_edit_acc.tr()),
                    SizedBox(height: 20),

                    // addTextFieldWidget(objNum: 1),
                    // addTextFieldWidget(objNum: 2),
//
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container site
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),

                                ButtonPastSite(
                                  num: 1,
                                ),

                                SizedBox(
                                  width: 5,
                                ),

                                TextFieldSite(
                                  textLbl: LocaleKeys.c_site.tr(),
                                  num: 1,
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
//
                                SizedBox(
                                  width: 12,
                                  height: 50,
                                ),

                                ButtonQuestionSite(num: 1),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddSiteProvider>().hintSite,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container site
                    SizedBox(height: 10),

                    //
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container login
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),

                                ButtonPastSite(
                                  num: 2,
                                ),

                                SizedBox(
                                  width: 5,
                                ),
                                TextFieldSite(
                                  textLbl: LocaleKeys.c_login.tr(),
                                  num: 2,
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
//
                                SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionSite(num: 2),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddSiteProvider>().hintLogin,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container login
                    SizedBox(height: 10),

                    //
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container pass
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<AddSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),

                                ButtonPastSite(
                                  num: 3,
                                ),

                                SizedBox(
                                  width: 5,
                                ),
                                TextFieldSite(
                                  textLbl: LocaleKeys.c_pass.tr(),
                                  num: 3,
                                ),

//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button generation pass
//
                                SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: NeumorphicRadio(
                                      style: NeumorphicRadioStyle(
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(5)),
                                        intensity: 0.9,
                                        selectedDepth: -4,
                                        unselectedDepth: 2,
                                        border: NeumorphicBorder(
                                          color: context
                                              .watch<ThemeProvider>()
                                              .borderColor,
                                          width: 0.8,
                                        ),
                                        lightSource: LightSource.topLeft,
                                        selectedColor: context
                                            .watch<ThemeProvider>()
                                            .buttonFill,
                                        unselectedColor: context
                                            .watch<ThemeProvider>()
                                            .fillColor,
                                      ),
                                      groupValue: 11,
                                      value: 10,
                                      onChanged: (value) => {
                                        _showModalGenPass(context),
                                      },
                                      child: Center(
                                        child: NeumorphicIcon(
                                          Icons.new_releases_outlined,
                                          size: 22,
                                          style: NeumorphicStyle(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .iconColor,
                                          ),
                                        ),
                                      ),
                                      // Text("2012"),
                                    ),
                                  ),
                                ),

//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button pass

//
                                SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionSite(num: 3),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddSiteProvider>().hintPass,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container pass
                    SizedBox(height: 10),

                    //
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container note
//
                    Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().fillColor,
                          border: Border.all(
                            color: context.watch<ThemeProvider>().borderColor,
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                ButtonPastSite(
                                  num: 4,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextFieldSite(
                                  textLbl: LocaleKeys.c_note.tr(),
                                  num: 4,
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
//
                                SizedBox(
                                  width: 12,
                                  height: 50,
                                ),
                                ButtonQuestionSite(num: 4),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<AddSiteProvider>().hintNote,
                                maxLines: 10,
                                style: TextStyle(
                                  color:
                                      context.watch<ThemeProvider>().textColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//! >>>>>>>>>>>>>>>>>>> end container note

                    SizedBox(height: 30),

                    ButtonFormAdd(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalGenPass(BuildContext context) {
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
          title: Text(LocaleKeys.gen_pass_lbl.tr()),
          content: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(LocaleKeys.gen_pass_dec.tr()),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<AddSiteProvider>().lengthVol.toString(),
                      style: TextStyle(
                        color: context.watch<ThemeProvider>().textColor,
                      ),
                    ),
                  ],
                ),
                // // SizedBox(width: 12),
                // Expanded(
                //   child:
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: NeumorphicSlider(
                    height: 18,
                    min: 4,
                    max: 25,
                    style: SliderStyle(
                      accent: Colors.deepPurple,
                      variant: context.watch<ThemeProvider>().buttonFill,
                    ),
                    value:
                        context.watch<AddSiteProvider>().lengthVol.toDouble(),
                    onChanged: (value) {
                      context
                          .read<AddSiteProvider>()
                          .changeLengthVol(value.toInt());
                    },
                  ),
                ),
                // ),
                // // SizedBox(width: 12),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: NeumorphicSwitch(
                          value: context.watch<AddSiteProvider>().letter,
                          style: NeumorphicSwitchStyle(
                              activeTrackColor:
                                  context.watch<ThemeProvider>().buttonFill,
                              activeThumbColor: Colors.deepPurple,
                              thumbShape: NeumorphicShape.flat
                              //or convex, concave
                              ),
                          onChanged: (value) {
                            context.read<AddSiteProvider>().changeLetter(value);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        LocaleKeys.gen_pass_az.tr(),
                        style: TextStyle(
                            color: context.watch<ThemeProvider>().textColor),
                      ),
                    ],
                  ),
                ),
                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: NeumorphicSwitch(
                          value: context.watch<AddSiteProvider>().isSpecial,
                          style: NeumorphicSwitchStyle(
                              activeTrackColor:
                                  context.watch<ThemeProvider>().buttonFill,
                              activeThumbColor: Colors.deepPurple,
                              thumbShape: NeumorphicShape.flat
                              //or convex, concave
                              ),
                          onChanged: (value) {
                            context
                                .read<AddSiteProvider>()
                                .changeIsSpecial(value);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        LocaleKeys.gen_pass_sim.tr(),
                        style: TextStyle(
                            color: context.watch<ThemeProvider>().textColor),
                      ),
                    ],
                  ),
                ),
                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: NeumorphicSwitch(
                          value: context.watch<AddSiteProvider>().isNumber,
                          style: NeumorphicSwitchStyle(
                              activeTrackColor:
                                  context.watch<ThemeProvider>().buttonFill,
                              activeThumbColor: Colors.deepPurple,
                              thumbShape: NeumorphicShape.flat
                              //or convex, concave
                              ),
                          onChanged: (value) {
                            context
                                .read<AddSiteProvider>()
                                .changeIsNumber(value);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        LocaleKeys.gen_pass_dig.tr(),
                        style: TextStyle(
                            color: context.watch<ThemeProvider>().textColor),
                      ),
                    ],
                  ),
                ),
                //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await context.read<AddSiteProvider>().changePassVol();
                editingController.text =
                    await context.read<AddSiteProvider>().genPassVol;
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
