import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/provider/add_edit_site_provider.dart';
import 'package:sbox/provider/radio_provider.dart';
import 'package:sbox/provider/theme_provider.dart';

class radioButtonWidget extends StatelessWidget {
  radioButtonWidget({
    Key? key,
    required this.objNum,
  }) : super(key: key);

  int objNum;
  //bool selectRadio = true;
  // int groupValue = 1;
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
              selectedColor: context.watch<ThemeProvider>().fillSelectedColor,
              unselectedColor: context.watch<ThemeProvider>().fillColor,
            ),
            // groupValue: context.watch<AddSiteProvider>().hintOn,
            // value: context.watch<AddSiteProvider>().hintOn2,
            onChanged: (value) =>
                context.read<AddSiteProvider>().changeHintOn(objNum),
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
        SizedBox(
          width: 8,
          height: 50,
        ),
      ],
    );
  }
}
