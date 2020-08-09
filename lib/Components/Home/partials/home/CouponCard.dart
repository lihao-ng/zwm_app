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
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              height: 180,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${coupon.id}",
                child: Image.asset(coupon.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
            child: Text(
              // Coupons is out demo list
              coupon.title,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Text(
            "\$${coupon.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
