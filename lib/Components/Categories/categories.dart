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
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingMid,
        ),
        child: Column(
          children: <Widget>[
            FadeAnimation(
              1,
              Text('Categories', style: _theme.textTheme.headline1),
            ),
            SizedBox(height: spacingSmall),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: spacingSmall),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => {},
                    child: Container(
                      width: _size.width,
                      height: 80,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              categories[index].image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: Text(
                              categories[index].title,
                              style: _theme.textTheme.headline3
                                  .copyWith(color: accentColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
