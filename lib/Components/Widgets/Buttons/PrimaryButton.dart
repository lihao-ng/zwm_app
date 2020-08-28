import 'package:flutter/material.dart';
import 'package:zwm_app/constants.dart';

Container primaryButton({
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
      ),
      onPressed: () => onClick(),
      color: color,
      child: Text(
        text,
        style: style,
      ),
    ),
  );
}
