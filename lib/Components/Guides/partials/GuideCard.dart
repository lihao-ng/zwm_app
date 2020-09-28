import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Guide.dart';
import 'package:zwm_app/constants.dart';

class GuideCard extends StatelessWidget {
  final Guide guide;
  final Function press;

  const GuideCard({
    Key key,
    this.guide,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: press,
      child: Container(
        width: _size.width,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: spacingSmall),
            CircleAvatar(
              backgroundImage: guide.photo != ""
                  ? NetworkImage(guide.photo)
                  : AssetImage(
                      'assets/images/categories/bulk.jpg',
                    ),
            ),
            SizedBox(width: spacingMid),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      guide.name,
                      style: _theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tertiaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      guide.category,
                      style: _theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
