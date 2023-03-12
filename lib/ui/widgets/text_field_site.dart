import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/theme_provider.dart';

class TextFieldSite extends StatelessWidget {
  String textLbl;
  String initVol = '';
  bool autofocusVol = false;
  int num;
  final bColor = ColorsSHM();

  TextFieldSite({
    Key? key,
    required this.textLbl,
    required this.num,
    this.autofocusVol = false,
    this.initVol = '',
  }) : super(key: key);

  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    editingController.text = context.watch<AddSiteProvider>().setTextVol(num);
    editingController.selection =
        TextSelection.collapsed(offset: editingController.text.length);

    return Flexible(
      child: TextFormField(
        autofocus: autofocusVol,
        controller: editingController,
        // initialValue: initVol,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: context.watch<ThemeProvider>().textColor,
          decoration: TextDecoration.none,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          fillColor: context.watch<ThemeProvider>().fillColor,
          focusColor: context.watch<ThemeProvider>().textColor,
          hoverColor: context.watch<ThemeProvider>().textColor,
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: context.watch<ThemeProvider>().borderColor,
          ),
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: context.watch<ThemeProvider>().borderColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                color: context.watch<ThemeProvider>().fillSelectedColor,
                style: BorderStyle.solid,
                width: 1.0),
            //color: _textColor(context)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.watch<ThemeProvider>().fillSelectedColor,
                width: 2.0),
          ),
          labelText: textLbl,
          // hintText: LocaleKeys.c_site.tr(),
        ),
        onChanged: (val) =>
            context.read<AddSiteProvider>().changeDataText(val, num),
        //task = val,
      ),
    );
  }
}
