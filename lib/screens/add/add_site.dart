import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sbox/models/translat_locale_keys.g.dart';
import 'package:sbox/models/secstor.dart';
import 'package:sbox/client/hive_names.dart';

class AddSite extends StatefulWidget {
  final formKey = GlobalKey<FormState>();

  @override
  _AddSiteState createState() => _AddSiteState();
}

class _AddSiteState extends State<AddSite> {
  late String task;
  late String note;
  late String login;
  late String pass;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.lLabel.tr(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          task = value;
                        });
                      },
                      validator: (val) {
                        return val!.trim().isEmpty
                            ? LocaleKeys.Label_name_should_not_be_empty.tr()
                            : null;
                      },
                    ),
                    TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.clogin.tr(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          login = value == null ? '' : value;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.cpass.tr(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          pass = value == null ? '' : value;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.Note.tr(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          note = value == null ? '' : value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          child: Text(
                            LocaleKeys.Add.tr(),
                          ),
                          onPressed: _validateAndSave,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
        LocaleKeys.form_is_invalid.tr(),
      );
    }
  }

  void _onFormSubmit() {
    Box<C_hive> contactsBox = Hive.box<C_hive>(HiveBoxes.db_hive);
    contactsBox.add(C_hive(task: task, note: note, login: login, pass: pass));
    Navigator.of(context).pop();
  }
}
