import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:sbox/provider/add_site_provider.dart';
import 'package:sbox/provider/radio_provider.dart';
import 'package:sbox/ui/widgets/radio_button_nm.dart';

class addTextFieldWidget extends StatelessWidget {
  addTextFieldWidget({
    Key? key,
    required this.objNum,
  }) : super(key: key);

  int objNum;
  final bColor = ColorsSHM();

//part of 'package:sbox/ui/screens/main_screen.dart';

  @override
  Widget build(BuildContext context) {
    return Container(
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
            //   context.watch<AddSiteProvider>().dataSite.toString(),
            // ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    autofocus: true,
                    initialValue: '',
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
                            color: _fillSelectedColor(context), width: 2.0),
                      ),
                      labelText: context.watch<AddSiteProvider>().hintSite,
                      // hintText: LocaleKeys.c_site.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),

                        //color: _textColor(context)
                      ),
                    ),
                    onChanged: (val) => context
                        .read<AddSiteProvider>()
                        .changeDataText(val, objNum),
                    //task = val,
                  ),
                ),
//
// ! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//

                Align(
                  alignment: Alignment.topRight,
                  child: radioButtonWidget(objNum: objNum),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child:
                  Text(context.watch<AddSiteProvider>().hintSite, maxLines: 10),
            ),
          ],
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
}
