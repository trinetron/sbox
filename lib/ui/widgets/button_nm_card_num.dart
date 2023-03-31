import 'package:clipboard/clipboard.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/sound_provider.dart';
import 'package:sbox/provider/theme_provider.dart';

class ButtonMN_CardNum extends StatelessWidget {
  String textBtn;
  String textLbl;
  final bColor = ColorsSHM();

  ButtonMN_CardNum({
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
            context.read<SoundProvider>().playSound('button');
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
                        ? cardNumFormater(textBtn)
                        : cardNumFormaterX(textBtn),
                    style: GoogleFonts.yujiSyuku(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
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

  String cardNumFormater(String inputText) {
    String resultStr = '';

    for (int i = 0; i < inputText.length; i++) {
      resultStr += (inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        resultStr += (' ');
      }
    }

    return resultStr;
  }

  String cardNumFormaterX(String inputText) {
    String resultStr = 'XXXX XXXX XXXX ';

    for (int i = 0; i < inputText.length; i++) {
      if (i >= 12) {
        resultStr += (inputText[i]);
      }
      var nonZeroIndexValue = i + 1;
    }

    return resultStr;
  }
}
