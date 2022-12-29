import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';

class ContainerMN extends StatefulWidget {
  ContainerMN({
    Key? key,
    this.textCont = '',
  }) : super(key: key);

  String textCont;

  @override
  _ContainerMNState createState() => _ContainerMNState();
}

class _ContainerMNState extends State<ContainerMN> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            height: 35,
            child: Neumorphic(
              margin: EdgeInsets.only(top: 2.0, bottom: 3.0),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(6)),
              ),
              padding: const EdgeInsets.all(3.0),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.center,
                initialValue: widget.textCont,
                readOnly: true,
                style: TextStyle(color: _textColor(context)),
                //selectionEnabled: true,
              ),
            ),
          )),
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
