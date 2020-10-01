import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/constants.dart';

class CouponTab extends StatefulWidget {
  final String name;
  final List<Offer> coupons;

  const CouponTab({@required this.name, @required this.coupons});

  CouponTabState createState() => CouponTabState();
}

class CouponTabState extends State<CouponTab> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      color: accentColor,
      margin: EdgeInsets.only(bottom: spacingSmall),
      padding: EdgeInsets.all(paddingMid),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: _theme.textTheme.headline3,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: spacingSmall),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.1 / 2.9,
            crossAxisSpacing: paddingLarge,
            children: widget.coupons.map<Widget>((Offer offer) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/coupon-detail',
                  arguments: offer,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: offer.photo,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 140,
                        ),
                      ),
                      Container(
                        height: 70,
                        padding: EdgeInsets.fromLTRB(0, paddingSmall, 0, 0),
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
                                style: _theme.textTheme.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
