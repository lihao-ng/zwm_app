import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/constants.dart';

Widget logo({color}) {
  var boxColor = primaryColor;
  var logoColor = accentColor;

  if (color == 'white') {
    boxColor = accentColor;
    boxColor = primaryColor;
  }

  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      color: boxColor,
      shape: BoxShape.circle,
    ),
    child: Icon(
      MaterialCommunityIcons.leaf,
      color: logoColor,
      size: logoSize,
    ),
  );
}
