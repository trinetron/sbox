import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sbox/models/design/theme.dart';
import 'package:sbox/provider/theme_provider.dart';

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
                    color: context.watch<ThemeProvider>().borderColor,
                    width: 0.8,
                  ),
                  lightSource: LightSource.topLeft,
                  color: context.watch<ThemeProvider>().fillColor),

              padding: const EdgeInsets.all(6.0),

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
                          color: context.watch<ThemeProvider>().textColor,
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
}
