import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:open_url/open_url.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TopBodyText extends StatelessWidget {
  String textLbl;
  final bColor = ColorsSHM();

  TopBodyText({
    Key? key,
    required this.textLbl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: NeumorphicTheme.accentColor(context),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Center(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 4.0, right: 4.0, top: 6.0, bottom: 8.0),
        child: Text(
          textLbl,
          style: TextStyle(
            color: _textColor(context),
            decoration: TextDecoration.none,
            fontSize: 15,
          ),
        ),
      )),
    );
  }

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
