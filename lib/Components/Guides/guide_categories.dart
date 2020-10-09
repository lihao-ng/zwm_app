import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/GuideCategory.dart';
import 'package:zwm_app/constants.dart';

class GuideCategories extends StatefulWidget {
  @override
  _GuideCategoriesState createState() => _GuideCategoriesState();
}

class _GuideCategoriesState extends State<GuideCategories> {
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
                'Guides',
                style: _theme.textTheme.headline1,
              ),
            ),
            SizedBox(height: spacingSmall),
            TextField(
              onTap: () => Navigator.pushNamed(context, '/guide-search'),
              readOnly: true,
              decoration: InputDecoration(
                fillColor: accentColor,
                filled: true,
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
            SizedBox(height: spacingSmall),
            Expanded(
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: spacingMin,
                crossAxisSpacing: spacingMin,
                padding: EdgeInsets.all(paddingSmall),
                childAspectRatio:
                    (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children:
                    guideCategories.map<Widget>((GuideCategory guideCategory) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/guide-list',
                        arguments: guideCategory.title,
                      );
                    },
                    child: GridTile(
                      footer: GridTileBar(
                        title: Text(
                          guideCategory.title,
                          style: _theme.textTheme.bodyText2,
                          maxLines: 2,
                        ),
                        backgroundColor: Colors.black45,
                        leading: Image.asset(
                          guideCategory.icon,
                          color: Colors.white,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      child: Image.asset(
                        guideCategory.image,
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
