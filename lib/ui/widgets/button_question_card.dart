import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/languages/translat_locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sbox/provider/add_card_provider.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/permissions_provider.dart';
import 'package:sbox/provider/theme_provider.dart';

class ButtonQuestionCard extends StatelessWidget {
  int num;
  final bColor = ColorsSHM();

  ButtonQuestionCard({
    Key? key,
    required this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 30,
        height: 30,
        child: NeumorphicRadio(
          style: NeumorphicRadioStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
            intensity: 0.9,
            selectedDepth: -4,
            unselectedDepth: 2,
            border: NeumorphicBorder(
              color: context.watch<ThemeProvider>().borderColor,
              width: 0.8,
            ),
            lightSource: LightSource.topLeft,
            selectedColor: context.watch<ThemeProvider>().buttonFill,
            unselectedColor: context.watch<ThemeProvider>().fillColor,
          ),
          groupValue: context.watch<AddCardProvider>().hintOn(num),
          value: num,
          onChanged: (value) =>
              context.read<AddCardProvider>().changeHintOn(num),
          child: Center(
            child: NeumorphicIcon(
              Icons.question_mark,
              size: 22,
              style: NeumorphicStyle(
                color: context.watch<ThemeProvider>().iconColor,
              ),
            ),
          ),
          // Text("2012"),
        ),
      ),
    );
  }
}
