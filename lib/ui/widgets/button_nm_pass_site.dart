import 'package:clipboard/clipboard.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/theme_provider.dart';

class ButtonMN_PassSite extends StatelessWidget {
  String textBtn;
  String textLbl;
  final bColor = ColorsSHM();

  ButtonMN_PassSite({
    Key? key,
    required this.textBtn,
    required this.textLbl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
        child: NeumorphicButton(
          margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          onPressed: () async {
            if (textBtn != '') {
              await FlutterClipboard.copy(textBtn)
                  .then((value) => debugPrint('$textBtn copied'));
              // copied successfully
              String tmpStr = textBtn;
              tmpStr += ' - ';
              tmpStr += LocaleKeys.c_copy.tr();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(tmpStr),
              ));
            }
          },
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(2)),
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  textLbl,
                  style: TextStyle(
                      fontSize: 10,
                      color: context.watch<ThemeProvider>().textColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  8.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    context.watch<PermissionsService>().showPassword
                        ? textBtn
                        : '* * * * * * *',
                    style: TextStyle(
                        fontSize: 12,
                        color: context.watch<ThemeProvider>().textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
