import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class CouponCard extends StatelessWidget {
  final Offer offer;
  final Function press;

  const CouponCard({
    Key key,
    this.offer,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: press,
      child: Hero(
        tag: 'hero-' + offer.id.toString(),
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          return SingleChildScrollView(
            child: fromHeroContext.widget,
          );
        },
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: _size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: offer.photo,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 150,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        paddingMid, paddingSmall, paddingSmall, paddingSmall),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          offer.name,
                          style: _theme.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tertiaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          offer.type,
                          style: _theme.textTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: spacingMid),
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: offer.points.toString(),
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " points",
                                style: _theme.textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
