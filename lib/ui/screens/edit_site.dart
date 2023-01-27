import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/provider/add_site_provider.dart';
import 'package:sbox/models/local_db/provider/edit_site_provider.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/ui/widgets/add_textfield_nm.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';
import 'package:sbox/ui/widgets/button_form_add.dart';
import 'package:sbox/ui/widgets/button_form_edit.dart';
import 'package:sbox/ui/widgets/button_nm.dart';
import 'package:sbox/ui/widgets/radio_button_nm.dart';

class EditSite extends StatelessWidget {
  final bColor = ColorsSHM();
  int id;
  String task;
  String note;
  String login;
  String pass;
  final _formKey = GlobalKey<FormState>();

  EditSite({
    // super.key,
    required this.id,
    required this.task,
    required this.login,
    required this.pass,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // addTextFieldWidget(objNum: 1),
                    // addTextFieldWidget(objNum: 2),
//
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> container site
//
                    Container(
                      decoration: BoxDecoration(
                          color: _fillColor(context),
                          border: Border.all(
                            color: _borderColor(context),
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<EditSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                      autofocus: true,
                                      initialValue: task,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: _textColor(context),
                                        decoration: TextDecoration.none,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: _fillColor(context),
                                        focusColor: _textColor(context),
                                        hoverColor: _textColor(context),
                                        labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color:
                                                  _fillSelectedColor(context),
                                              style: BorderStyle.solid,
                                              width: 1.0),
                                          //color: _textColor(context)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  _fillSelectedColor(context),
                                              width: 2.0),
                                        ),
                                        labelText: LocaleKeys.c_site.tr(),
                                        // hintText: LocaleKeys.c_site.tr(),
                                      ),
                                      onChanged: (val) => {
                                            task = val,
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(val, 1),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(login, 2),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(pass, 3),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(note, 4),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataId(id),
                                          }
                                      //task = val,
                                      ),
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
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
                                          color: _borderColor(context),
                                          width: 0.8,
                                        ),
                                        lightSource: LightSource.topLeft,
                                        selectedColor:
                                            _fillSelectedColor(context),
                                        unselectedColor: _fillColor(context),
                                      ),
                                      groupValue: context
                                          .watch<EditSiteProvider>()
                                          .hintOnSite,
                                      value: 1,
                                      onChanged: (value) => context
                                          .read<EditSiteProvider>()
                                          .changeHintOn(1),
                                      child: Center(
                                        child: NeumorphicIcon(
                                          Icons.question_mark,
                                          size: 22,
                                          style: NeumorphicStyle(
                                            color: _iconColor(context),
                                          ),
                                        ),
                                      ),
                                      // Text("2012"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<EditSiteProvider>().hintSite,
                                maxLines: 10,
                                style: TextStyle(
                                  color: _textColor(context),
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
                          color: _fillColor(context),
                          border: Border.all(
                            color: _borderColor(context),
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<EditSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                      autofocus: true,
                                      initialValue: login,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: _textColor(context),
                                        decoration: TextDecoration.none,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: _fillColor(context),
                                        focusColor: _textColor(context),
                                        hoverColor: _textColor(context),
                                        labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  _fillSelectedColor(context),
                                              width: 2.0),
                                        ),
                                        labelText: LocaleKeys.c_login.tr(),
                                        // hintText: LocaleKeys.c_site.tr(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),

                                          //color: _textColor(context)
                                        ),
                                      ),
                                      onChanged: (val) => {
                                            login = val,
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(val, 2),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(task, 1),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(pass, 3),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(note, 4),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataId(id),
                                          }
                                      //task = val,
                                      ),
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
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
                                          color: _borderColor(context),
                                          width: 0.8,
                                        ),
                                        lightSource: LightSource.topLeft,
                                        selectedColor:
                                            _fillSelectedColor(context),
                                        unselectedColor: _fillColor(context),
                                      ),
                                      groupValue: context
                                          .watch<EditSiteProvider>()
                                          .hintOnLogin,
                                      value: 2,
                                      onChanged: (value) => context
                                          .read<EditSiteProvider>()
                                          .changeHintOn(2),
                                      child: Center(
                                        child: NeumorphicIcon(
                                          Icons.question_mark,
                                          size: 22,
                                          style: NeumorphicStyle(
                                            color: _iconColor(context),
                                          ),
                                        ),
                                      ),
                                      // Text("2012"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<EditSiteProvider>().hintLogin,
                                maxLines: 10,
                                style: TextStyle(
                                  color: _textColor(context),
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
                          color: _fillColor(context),
                          border: Border.all(
                            color: _borderColor(context),
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<EditSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                      autofocus: true,
                                      initialValue: pass,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: _textColor(context),
                                        decoration: TextDecoration.none,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: _fillColor(context),
                                        focusColor: _textColor(context),
                                        hoverColor: _textColor(context),
                                        labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  _fillSelectedColor(context),
                                              width: 2.0),
                                        ),
                                        labelText: LocaleKeys.c_pass.tr(),
                                        // hintText: LocaleKeys.c_site.tr(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),

                                          //color: _textColor(context)
                                        ),
                                      ),
                                      onChanged: (val) => {
                                            pass = val,
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(val, 3),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(login, 2),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(task, 1),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(note, 4),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataId(id),
                                          }
                                      //task = val,
                                      ),
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button pass
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
                                          color: _borderColor(context),
                                          width: 0.8,
                                        ),
                                        lightSource: LightSource.topLeft,
                                        selectedColor:
                                            _fillSelectedColor(context),
                                        unselectedColor: _fillColor(context),
                                      ),
                                      groupValue: context
                                          .watch<EditSiteProvider>()
                                          .hintOnPass,
                                      value: 3,
                                      onChanged: (value) => context
                                          .read<EditSiteProvider>()
                                          .changeHintOn(3),
                                      child: Center(
                                        child: NeumorphicIcon(
                                          Icons.question_mark,
                                          size: 22,
                                          style: NeumorphicStyle(
                                            color: _iconColor(context),
                                          ),
                                        ),
                                      ),
                                      // Text("2012"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<EditSiteProvider>().hintPass,
                                maxLines: 10,
                                style: TextStyle(
                                  color: _textColor(context),
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
                          color: _fillColor(context),
                          border: Border.all(
                            color: _borderColor(context),
                            width: 2, //width of border
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Text(
                            //   context.watch<EditSiteProvider>().dataSite.toString(),
                            // ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                      autofocus: true,
                                      initialValue: note,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: _textColor(context),
                                        decoration: TextDecoration.none,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: _fillColor(context),
                                        focusColor: _textColor(context),
                                        hoverColor: _textColor(context),
                                        labelStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          color: _borderColor(context),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  _fillSelectedColor(context),
                                              width: 2.0),
                                        ),
                                        labelText: LocaleKeys.c_note.tr(),
                                        // hintText: LocaleKeys.c_site.tr(),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),

                                          //color: _textColor(context)
                                        ),
                                      ),
                                      onChanged: (val) => {
                                            note = val,
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(val, 4),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(login, 2),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(pass, 3),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataText(task, 1),
                                            context
                                                .read<EditSiteProvider>()
                                                .changeDataId(id),
                                          }
                                      //task = val,
                                      ),
                                ),
//
// ? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> button
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
                                          color: _borderColor(context),
                                          width: 0.8,
                                        ),
                                        lightSource: LightSource.topLeft,
                                        selectedColor:
                                            _fillSelectedColor(context),
                                        unselectedColor: _fillColor(context),
                                      ),
                                      groupValue: context
                                          .watch<EditSiteProvider>()
                                          .hintOnNote,
                                      value: 4,
                                      onChanged: (value) => context
                                          .read<EditSiteProvider>()
                                          .changeHintOn(4),
                                      child: Center(
                                        child: NeumorphicIcon(
                                          Icons.question_mark,
                                          size: 22,
                                          style: NeumorphicStyle(
                                            color: _iconColor(context),
                                          ),
                                        ),
                                      ),
                                      // Text("2012"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                context.watch<EditSiteProvider>().hintNote,
                                maxLines: 10,
                                style: TextStyle(
                                  color: _textColor(context),
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
                    SizedBox(height: 10),

                    SizedBox(height: 20),

                    ButtonFormEdit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _fillSelectedColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.radioFillL;
    } else {
      return bColor.radioFillD;
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
    final theme = NeumorphicTheme.of(context);
    if (!theme!.isUsingDark) {
      return bColor.buttonFillL;
    } else {
      return bColor.buttonFillD;
    }
  }

  Color _borderColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.borderL;
    } else {
      return bColor.borderD;
    }
  }

  Color? _iconColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (!theme!.isUsingDark) {
      return bColor.iconL;
    } else {
      return bColor.iconD;
    }
  }
}
