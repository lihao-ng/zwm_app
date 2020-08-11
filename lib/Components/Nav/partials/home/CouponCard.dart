import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Coupon.dart';

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

    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          width: 180,
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                coupon.image,
                fit: BoxFit.fill,
                width: 180,
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
                        "${coupon.title}\n",
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: Text(
                        '${coupon.price} points',
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
    );
  }
}
