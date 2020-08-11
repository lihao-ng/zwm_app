import 'package:flutter/material.dart';

GestureDetector secondaryButton({
  VoidCallback onClick,
  String text,
  Color color,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
