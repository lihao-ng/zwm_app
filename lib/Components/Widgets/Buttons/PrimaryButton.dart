import 'package:flutter/material.dart';

GestureDetector primaryButton({
  VoidCallback onClick,
  String text,
  TextStyle style,
  Color color,
  double padding = 20,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(padding),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    ),
  );
}
