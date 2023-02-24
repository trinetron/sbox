import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/add_site_provider.dart';
import 'package:sbox/ui/screens/add_site.dart';
import 'package:sbox/ui/screens/backup_screen.dart';

import '../../provider/radio_provider.dart';

class ButtonAppBarBackup extends StatelessWidget {
  ButtonAppBarBackup({
    Key? key,
    required this.iconBtn,
  }) : super(key: key);

  IconData iconBtn;
  final bColor = ColorsSHM();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        height: 40,
        width: 45,
        child: NeumorphicButton(
          margin: EdgeInsets.only(left: 3),
          onPressed: () => {
            // context.read<AddSiteProvider>().cleanDataText(),
            context.read<RadioProvider>().changeInt(0, context),
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BackupScreen()),
              (Route<dynamic> route) => false,
            ),
          },
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              depth: 2,
              intensity: 0.9,
              surfaceIntensity: 0.9,
              border: NeumorphicBorder(
                color: _borderColor(context),
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              color: _fillColor(context)),

          padding: const EdgeInsets.all(7.0),
          child: NeumorphicIcon(
            iconBtn,
            size: 25,
            style: NeumorphicStyle(
              color: _iconColor(context),
            ),
          ),
          //  Text(
          //   "Toggle Theme",
          //   style: TextStyle(color: NeumorphicTheme.accentColor(context)),
          // ),
        ),
      ),
    );
  }

  Color? _iconColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (!theme!.isUsingDark) {
      return bColor.iconL;
    } else {
      return bColor.iconD;
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

  Color? _textColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.buttonTextD;
    } else {
      return bColor.buttonTextL;
    }
  }
}
