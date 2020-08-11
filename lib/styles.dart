import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/constants.dart';

const zwmGreen = MaterialColor(
  primaryColorHex,
  const <int, Color>{
    50: Color.fromRGBO(142, 182, 0, 0.1),
    100: Color.fromRGBO(142, 182, 0, 0.2),
    200: Color.fromRGBO(142, 182, 0, 0.3),
    300: Color.fromRGBO(142, 182, 0, 0.4),
    400: Color.fromRGBO(142, 182, 0, 0.5),
    500: Color.fromRGBO(142, 182, 0, 0.6),
    600: Color.fromRGBO(142, 182, 0, 0.7),
    700: Color.fromRGBO(142, 182, 0, 0.8),
    800: Color.fromRGBO(142, 182, 0, 0.9),
    900: Color.fromRGBO(142, 182, 0, 1),
  },
);

const greenHeadline = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
  color: zwmGreen,
);

const whiteHeadline = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
  color: accentColor,
);

const appBarHeadline = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
  color: zwmGreen,
);

const greenBody = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.normal,
  fontSize: bodyTextSize,
  color: zwmGreen,
);

const whiteBody = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.normal,
  fontSize: bodyTextSize,
  color: accentColor,
);

const caption = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.normal,
  fontSize: 12.0,
  color: captionColor,
);

const greenBtn = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: bodyTextSize,
  color: accentColor,
);
