import 'package:flutter/material.dart';

GestureDetector primaryButton({
  VoidCallback onClick,
  String text,
  TextStyle style,
  Color color,
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
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          text,
          style: style,
        ),
      ),
    ),
  );
}
