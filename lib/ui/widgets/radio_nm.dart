import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/models/local_db/provider/radio_provider.dart';

class radioWidget extends StatelessWidget {
  radioWidget({
    Key? key,
    this.textBtn = '',
  }) : super(key: key);

  String textBtn;
  bool selectRadio = true;
  int groupValue = 1;
  final bColor = ColorsSHM();

//part of 'package:sbox/ui/screens/main_screen.dart';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          height: 50,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: NeumorphicRadio(
            style: NeumorphicRadioStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              intensity: 0.9,
              selectedDepth: -4,
              unselectedDepth: 2,
              border: NeumorphicBorder(
                color: _borderColor(context),
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              selectedColor: _fillSelectedColor(context),
              unselectedColor: _fillColor(context),
            ),
            groupValue: context.watch<RadioProvider>().data,
            value: 1,
            onChanged: (value) => context.read<RadioProvider>().changeInt(1),

            // (groupValue) {
            // setState(() {
            //groupValue = value;
            //  setRadioButton();
            // });
            // groupValue = 1;
            // groupValueG = 1;
            // debugPrint(' groupValue  $groupValue');
            // debugPrint(' groupValueG  $groupValueG');

            // selectRadio = true;
            // },
            child: Center(
              child: NeumorphicIcon(
                Icons.password,
                size: 22,
                style: NeumorphicStyle(
                  color: _iconColor(context),
                ),
              ),
            ),
            // Text("2012"),
          ),
        ),
        SizedBox(
          width: 8,
          height: 50,
        ),
        SizedBox(
          width: 40,
          height: 40,
          child: NeumorphicRadio(
            style: NeumorphicRadioStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
              intensity: 0.9,
              selectedDepth: -4,
              unselectedDepth: 2,
              border: NeumorphicBorder(
                color: _borderColor(context),
                width: 0.8,
              ),
              lightSource: LightSource.topLeft,
              selectedColor: _fillSelectedColor(context),
              unselectedColor: _fillColor(context),
            ),

            groupValue: context.watch<RadioProvider>().data,
            value: 2,
            onChanged: (value) => context.read<RadioProvider>().changeInt(2),
            //  {
            // setState(() {
            // groupValue = 2;
            // groupValueG = 2;
            // debugPrint(' groupValue  $groupValue');
            // debugPrint(' groupValueG  $groupValueG');
            // });
            // context.read<AppBarProvider>().changeString(groupValue);
            // onChanged: (newData) => Provider.of<AppBarProvider>(context, listen: false),
            // },
            child: Center(
              child: NeumorphicIcon(
                Icons.credit_card,
                size: 22,
                style: NeumorphicStyle(
                  color: _iconColor(context),
                ),
              ),
            ),
            // Text("2012"),
          ),
        ),
      ],
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
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.buttonFillL;
    } else {
      return bColor.buttonFillD;
    }
  }

  Color? _fillSelectedColor(BuildContext context) {
    if (!NeumorphicTheme.isUsingDark(context)) {
      return bColor.radioFillL;
    } else {
      return bColor.radioFillD;
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

void setRadioButton() {}
