import 'package:flutter/material.dart';
import 'package:zwm_app/constants.dart';

class SideButtons extends StatelessWidget {
  final IconData icon;

  const SideButtons({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: paddingLarge, horizontal: paddingMid),
      child: Container(
        child: Icon(
          icon,
          size: 20.0,
          color: primaryColor,
        ),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: accentColor,
          boxShadow: [
            BoxShadow(
              color: tertiaryColor,
              blurRadius: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
