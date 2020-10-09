import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Category.dart';
import 'package:zwm_app/constants.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
            FadeAnimation(
              1,
              Text(
                'Categories',
                style: _theme.textTheme.headline1,
              ),
            ),
            SizedBox(height: spacingSmall),
            Expanded(
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: spacingMin,
                crossAxisSpacing: spacingMin,
                padding: EdgeInsets.all(paddingSmall),
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: categories.map<Widget>((Category category) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/merchants-list',
                          arguments: category);
                    },
                    child: GridTile(
                      footer: GridTileBar(
                        title: Text(
                          category.title,
                          style: _theme.textTheme.bodyText2,
                          maxLines: 2,
                        ),
                        backgroundColor: Colors.black45,
                        leading: Image.asset(
                          category.icon,
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      child: Image.asset(
                        category.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
