import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Coupons/partials/CouponCard.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/Services/OfferServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class CouponsList extends StatefulWidget {
  @override
  _CouponsListState createState() => _CouponsListState();
}

class _CouponsListState extends State<CouponsList> {
  // FOR LAZY LOADING
  // https://medium.com/@archelangelo/flutter-load-contents-lazily-on-scroll-made-simple-c6817f94e5d0

  List<Offer> _offers = [];
  int _page = 1;
  bool _offersLoading = true;
  bool _noOffers = false;

  ScrollController _scrollController = new ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _loadCoupons();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadCoupons();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadCoupons() {
    _offersLoading = true;

    OfferServices().index(
      type: 'Promo',
      page: _page,
      onSuccess: (List<Offer> offers, page) {
        setState(() {
          _offersLoading = false;
        });

        if (offers.length == 0) {
          setState(() {
            _noOffers = true;
          });
          return;
        }

        setState(() {
          _page = page + 1;
        });

        var future = Future(() {});

        for (var i = 0; i < offers.length; i++) {
          future = future.then((_) {
            return Future.delayed(Duration(milliseconds: 100), () {
              setState(() {
                _offers.add(offers[i]);
                _listKey.currentState.insertItem(_offers.length - 1);
              });
            });
          });
        }
      },
      onError: (response) {
        setState(() {
          _offersLoading = false;
        });

        errorAlert(
          context,
          title: "An error has occured!",
          body: response,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(paddingMid),
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
            if (_offersLoading == true)
              Expanded(
                child: Center(
                  child: SpinKitPouringHourglass(
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                ),
              ),
            if (_noOffers == true)
              Expanded(
                child: Center(
                  child: Text(
                    'No results found',
                    style: _theme.textTheme.headline3,
                  ),
                ),
              ),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                controller: _scrollController,
                padding: EdgeInsets.only(top: paddingSmall),
                initialItemCount: _offers.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position: CurvedAnimation(
                      curve: Curves.easeOut,
                      parent: animation,
                    ).drive((Tween<Offset>(
                      begin: Offset(1, 0),
                      end: Offset(0, 0),
                    ))),
                    child: Card(
                      elevation: 3,
                      child: CouponCard(
                        offer: _offers[index],
                        press: () => {
                          Navigator.pushNamed(
                            context,
                            '/coupon-detail',
                            arguments: _offers[index],
                          ),
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
