import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:sbox/models/design/theme.dart';

class ContainerMN extends StatelessWidget {
  String textCont;
  String textLbl;
  final bColor = ColorsSHM();

  ContainerMN({
    Key? key,
    required this.textCont,
    required this.textLbl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(
              left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
          child: Container(
            //height: 50,
            child: Neumorphic(
              margin: EdgeInsets.only(top: 2.0, bottom: 3.0),
              // style: NeumorphicStyle(
              //   shape: NeumorphicShape.convex,
              //   boxShape:
              //       NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
              // ),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
                  depth: 2,
                  intensity: 0.9,
                  surfaceIntensity: 0.9,
                  border: NeumorphicBorder(
                    color: _borderColor(context),
                    width: 0.8,
                  ),
                  lightSource: LightSource.topLeft,
                  color: _fillColor(context)),

              padding: const EdgeInsets.all(6.0),

              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textLbl,
                      style:
                          TextStyle(fontSize: 10, color: _textColor(context)),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        //scrollPadding: const EdgeInsets.all(1.0),
                        maxLines: 10,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        initialValue: textCont,
                        readOnly: true,
                        style: TextStyle(
                          color: _textColor(context),
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 3.1, horizontal: 3.1),
                        ),
                        //selectionEnabled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
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
