import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:open_url/open_url.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonMNwww extends StatelessWidget {
  String textBtn;
  String textLbl;
  final bColor = ColorsSHM();

  ButtonMNwww({
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
        child: GestureDetector(
          onLongPress: () async {
            await Clipboard.setData(ClipboardData(
              text: textBtn,
            ));
            // copied successfully
            String tmpStr = textBtn;
            tmpStr += ' - ';
            tmpStr += LocaleKeys.c_copy.tr();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(tmpStr),
            ));

            final result = await openUrl(textBtn);
            if (result.exitCode == 0) {
              debugPrint('URL should be open in your browser');
            } else {
              debugPrint(
                  'Something went wrong (exit code = ${result.exitCode}): '
                  '${result.stderr}');
            }
          },
          child: NeumorphicButton(
            margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(
                text: textBtn,
              ));
              // copied successfully
              String tmpStr = textBtn;
              tmpStr += ' - ';
              tmpStr += LocaleKeys.c_copy.tr();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(tmpStr),
              ));
            },

            style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(2)),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    textLbl,
                    style: TextStyle(fontSize: 10, color: _textColor(context)),
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
                      textBtn,
                      style:
                          TextStyle(fontSize: 12, color: _textColor(context)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Color? _iconsColor(BuildContext context) {
  //   final theme = NeumorphicTheme.of(context);
  //   if (!theme!.isUsingDark) {
  //     return theme.current!.accentColor;
  //   } else {
  //     return null;
  //   }
  // }

  Color _textColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Color? _fillColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (!theme!.isUsingDark) {
      return bColor.buttonFillL;
    } else {
      return bColor.buttonFillD;
    }
  }

  Color? _borderColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.borderL;
    } else {
      return bColor.borderD;
    }
  }
}
