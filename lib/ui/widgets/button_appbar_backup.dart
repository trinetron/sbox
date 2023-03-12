import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/theme_provider.dart';
import 'package:sbox/ui/screens/add_edit_site_screen.dart';
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
              PageRouteBuilder(
                  pageBuilder: (context, a1, a2) => BackupScreen()),
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
                color: context.watch<ThemeProvider>().borderColor,
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              color: context.watch<ThemeProvider>().fillColor),

          padding: const EdgeInsets.all(7.0),
          child: NeumorphicIcon(
            iconBtn,
            size: 25,
            style: NeumorphicStyle(
              color: context.watch<ThemeProvider>().iconColor,
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
}
