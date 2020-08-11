import 'package:flutter/material.dart';

import 'package:zwm_app/Components/Widgets/Logo.dart';
import 'package:zwm_app/constants.dart';

Widget appBar({hasSideIcon = true}) {
  return AppBar(
    backgroundColor: accentColor,
    automaticallyImplyLeading: hasSideIcon,
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    title: logo(),
    centerTitle: true,
  );
}

Widget customAppBar() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tertiaryColor,
          blurRadius: 5.0,
          offset: Offset(0.0, 0.75),
        )
      ],
      color: accentColor,
    ),
    child: Center(child: logo()),
  );
}
