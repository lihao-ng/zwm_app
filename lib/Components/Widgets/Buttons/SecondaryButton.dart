// import 'package:flutter/material.dart';

// GestureDetector secondaryButton({
//   VoidCallback onClick,
//   String text,
//   Color color,
// }) {
//   return GestureDetector(
//     onTap: () {
//       onClick();
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: color,
//           width: 2,
//         ),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       padding: EdgeInsets.all(20),
//       child: Center(
//         child: Text(
//           text,
//           style: TextStyle(
//             color: color,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:zwm_app/constants.dart';

Container secondaryButton({
  VoidCallback onClick,
  String text,
  TextStyle style,
  Color color,
  double width = double.infinity,
  double radius = 5,
  double padding = paddingLarge,
}) {
  return Container(
    width: width,
    child: RaisedButton(
      padding: EdgeInsets.symmetric(vertical: padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: color,
        ),
      ),
      onPressed: () => onClick(),
      color: accentColor,
      child: Text(
        text,
        style: style.copyWith(
          color: color,
        ),
      ),
    ),
  );
}
