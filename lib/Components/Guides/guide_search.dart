import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Category.dart';
import 'package:zwm_app/Models/GuideCategory.dart';
import 'package:zwm_app/constants.dart';

class GuideSearch extends StatefulWidget {
  @override
  _GuideSearchState createState() => _GuideSearchState();
}

class _GuideSearchState extends State<GuideSearch> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(paddingMid),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Search',
              style: _theme.textTheme.headline1,
            ),
            SizedBox(height: spacingSmall),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingMid + 2,
                  horizontal: paddingMid,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search object or material',
                hintStyle: TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
