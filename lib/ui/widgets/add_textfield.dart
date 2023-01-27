import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/models/local_db/secstor.dart';
import 'package:sbox/models/local_db/hive_names.dart';
import 'package:sbox/ui/widgets/button_appbar.dart';

class AddSite extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  AddSite({super.key});

  @override
  _AddSiteState createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  final bColor = ColorsSHM();
  late String task;
  late String note;
  late String login;
  late String pass;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'phone number?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onChanged: (val) => task = val,
                    ),
                    ButtonAppBarAdd(iconBtn: Icons.integration_instructions),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: _fillCardColor(context),
              //       border: Border.all(
              //         color: _borderColor(context),
              //         width: 2, //width of border
              //       ),
              //       borderRadius: BorderRadius.circular(5)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: Row(
              //       children: [
              //         TextFormField(
              //           autofocus: true,
              //           initialValue: '',
              //           decoration: InputDecoration(
              //             labelText: LocaleKeys.c_site.tr(),
              //           ),
              //           onChanged: (value) {
              //             setState(() {
              //               task = value;
              //             });
              //           },
              //           validator: (val) {
              //             return val!.trim().isEmpty
              //                 ? LocaleKeys.Label_empty.tr()
              //                 : null;
              //           },
              //         ),
              //         Expanded(
              //           child: SizedBox(),
              //         ),
              //         ButtonAppBarAdd(iconBtn: Icons.question_answer),
              //       ],
              //     ),
              //   ),
              // ),
              // TextFormField(
              //   initialValue: '',
              //   decoration: InputDecoration(
              //     labelText: LocaleKeys.c_login.tr(),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       login = value == null ? '' : value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   initialValue: '',
              //   decoration: InputDecoration(
              //     labelText: LocaleKeys.c_pass.tr(),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       pass = value == null ? '' : value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   initialValue: '',
              //   decoration: InputDecoration(
              //     labelText: LocaleKeys.c_note.tr(),
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       note = value == null ? '' : value;
              //     });
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    child: Text(
                      LocaleKeys.c_add.tr(),
                    ),
                    onPressed: _validateAndSave,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      _onFormSubmit();
    } else {
      print(
        LocaleKeys.form_invalid.tr(),
      );
    }
  }

  void _onFormSubmit() {
    Box<C_hive> contactsBox = Hive.box<C_hive>(HiveBoxes.db_hive);
    contactsBox.add(C_hive(task: task, note: note, login: login, pass: pass));
    Navigator.of(context).pop();
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
