import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Coupons/partials/CouponCard.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Coupon.dart';
import 'package:zwm_app/constants.dart';

class CouponsList extends StatefulWidget {
  @override
  _CouponsListState createState() => _CouponsListState();
}

class _CouponsListState extends State<CouponsList> {
  // final _pairList = <Coupon>[];

  // bool _isLoading = true;
  // bool _hasMore = true;

  // FOR LAZY LOADING LATER
  // https://medium.com/@archelangelo/flutter-load-contents-lazily-on-scroll-made-simple-c6817f94e5d0

  @override
  void initState() {
    super.initState();
    // _isLoading = true;
    // _hasMore = true;
    // _loadMore();
  }

// void _loadMore() {
//     _isLoading = true;
//     _itemFetcher.fetch().then((List<WordPair> fetchedList) {
//       if (fetchedList.isEmpty) {
//         setState(() {
//           _isLoading = false;
//           _hasMore = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           _pairList.addAll(fetchedList);
//         });
//       }
//     });
//   }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingLarge,
          vertical: paddingMid,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1,
              Text(
                'Rewards',
                style: _theme.textTheme.headline1,
              ),
            ),
            SizedBox(height: spacingSmall),
            Expanded(
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: spacingMid,
                  thickness: 2,
                ),
                itemBuilder: (context, index) {
                  return CouponCard(
                    coupon: coupons[index],
                    press: () => {
                      Navigator.pushNamed(context, '/coupon-detail',
                          arguments: coupons[index]),
                    },
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
