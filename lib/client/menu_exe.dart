// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sbox/screens/main_screen.dart';
// import 'package:rive/rive.dart';

// /// An example showing how to drive a StateMachine via a trigger input.
// class LittleMachine extends StatefulWidget {
//   const LittleMachine({Key? key}) : super(key: key);

//   @override
//   LittleMachineState createState() => LittleMachineState();
// }

// class LittleMachineState extends State<LittleMachine> {
//   /// Controller for playback
//   late StateMachineController _controller;
//   SMIInput<bool>? _bump;
//   String message = '';

//   void onInit(Artboard artboard) {
//     var ctrl = StateMachineController.fromArtboard(
//       artboard,
//       'SM1',
//       onStateChange: onStateChange,
//     ) as StateMachineController;
//     // ctrl.isActive = true;

//     artboard.addController(ctrl);
//     //_bump = _controller.findInput<bool>('in_b0') as SMIBool;

//     setState(() {
//       _controller = ctrl;
//     });
//   }

//   void onStateChange(
//     String stateMachineName,
//     String stateName,
//   ) =>
//       setState(() => {
//             message = 'State Changed in $stateMachineName to $stateName',
//             _bump = _controller.findInput<bool>('in_b0') as SMIBool,
//             print(message),
//             message = _bump!.value.toString(),
//             print(message),
//             //_controller.findInput<bool>('in_b0')!.value = false,
//           });

//   void _hitBump() {
//     if (_controller.findInput<bool>('in_b0')!.value == true) {
//       _controller.findInput<bool>('in_b0')!.value = false;
//     } else {
//       _controller.findInput<bool>('in_b0')!.value = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
