import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Merchants/partials/MerchantCard.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/constants.dart';

class MerchantsList extends StatefulWidget {
  final String category;

  const MerchantsList({@required this.category});

  @override
  _MerchantsListState createState() => _MerchantsListState();
}

class _MerchantsListState extends State<MerchantsList> {
  // final _pairList = <Merchant>[];

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
                widget.category,
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
                  return MerchantCard(
                    merchant: merchants[index],
                    press: () => {},
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
