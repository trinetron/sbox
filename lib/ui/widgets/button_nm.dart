import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ButtonMN extends StatefulWidget {
  ButtonMN({
    Key? key,
    this.textBtn = '',
  }) : super(key: key);

  String textBtn;

  @override
  _ButtonMNState createState() => _ButtonMNState();
}

class _ButtonMNState extends State<ButtonMN> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeumorphicButton(
          margin: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(
              text: widget.textBtn,
            ));
            // copied successfully
            String tmpStr = widget.textBtn;
            tmpStr += ' - ';
            tmpStr += LocaleKeys.Box_is_empty.tr();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(tmpStr),
            ));
          },
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
          ),
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.textBtn,
              style: TextStyle(color: _textColor(context)),
            ),
          ),
        ),
      ),
    );
  }

  Color? _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme!.isUsingDark) {
      return theme.current!.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
