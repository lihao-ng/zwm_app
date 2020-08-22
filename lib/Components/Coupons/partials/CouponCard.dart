import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Coupon.dart';
import 'package:zwm_app/constants.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final Function press;

  const CouponCard({
    Key key,
    this.coupon,
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
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                coupon.image,
                fit: BoxFit.fill,
                width: 140,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      coupon.title,
                      style: _theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, color: tertiaryColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Nude Zero Waste Store',
                      style: _theme.textTheme.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spacingLarge),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: coupon.price.toString(),
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
    );
  }
}
