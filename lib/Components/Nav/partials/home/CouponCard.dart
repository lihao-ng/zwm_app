import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zwm_app/Models/Offer.dart';

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

    return GestureDetector(
      onTap: press,
      child: Hero(
        tag: 'hero-' + offer.id.toString(),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: 200,
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: offer.photo,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "${offer.name}\n",
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Flexible(
                          child: Text(
                            '${offer.points} points',
                            overflow: TextOverflow.ellipsis,
                            style: _theme.textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
