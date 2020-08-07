import 'package:flutter/material.dart';

const largeTextSize = 30.0;
const mediumTextSize = 22.0;
const bodyTextSize = 14.0;

const fontName = 'Montserrat';

const zwmGreen = MaterialColor(
  // Color.fromRGBO(177, 194, 83, 0.1),
  0xFF8db600,
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
  // 0xFF00693E,
  // const <int, Color>{
  //   50: Color.fromRGBO(0, 105, 62, 0.1),
  //   100: Color.fromRGBO(0, 105, 62, 0.2),
  //   200: Color.fromRGBO(0, 105, 62, 0.3),
  //   300: Color.fromRGBO(0, 105, 62, 0.4),
  //   400: Color.fromRGBO(0, 105, 62, 0.5),
  //   500: Color.fromRGBO(0, 105, 62, 0.6),
  //   600: Color.fromRGBO(0, 105, 62, 0.7),
  //   700: Color.fromRGBO(0, 105, 62, 0.8),
  //   800: Color.fromRGBO(0, 105, 62, 0.9),
  //   900: Color.fromRGBO(0, 105, 62, 1),
  // },
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
  color: Colors.white,
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
  color: Colors.white,
);

const caption = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.normal,
  fontSize: 12.0,
  color: Colors.grey,
);

const greenBtn = TextStyle(
  fontFamily: fontName,
  fontWeight: FontWeight.bold,
  fontSize: bodyTextSize,
  color: Colors.white,
);
