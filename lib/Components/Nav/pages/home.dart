import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Nav/partials/home/CouponCard.dart';
import 'package:zwm_app/Components/Nav/partials/home/MerchantCard.dart';
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/Models/Merchant.dart';

import 'package:flutter/foundation.dart';
import 'package:zwm_app/Services/AuthServices.dart';
import 'package:zwm_app/Services/MerchantServices.dart';
import 'package:zwm_app/Services/OfferServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth _auth = new Auth();
  List<Offer> _offers = [];
  List<Merchant> _merchants = [];

  bool _offersLoading = true;
  bool _merchantsLoading = true;

  int _currentPoints = 0;

  @override
  void initState() {
    super.initState();
    _loadAccount();
    _loadCoupons();
    _loadMerchants();
  }

  _loadAccount() {
    AuthServices().updatePoints(
      onSuccess: (totalPoints, currentPoints) {
        if (!mounted) return;

        setState(() {
          _currentPoints = currentPoints;
        });
      },
      onError: (error) {},
    );

    Auth.getInstance(onInstance: (Auth auth) {
      if (!mounted) return;

      setState(() {
        _auth = auth;
      });
    });
  }

  _loadCoupons() {
    _offersLoading = true;

    OfferServices().index(
      type: 'Promo',
      limit: 6,
      page: 1,
      onSuccess: (List<Offer> offers, page) {
        if (!mounted) return;

        setState(() {
          _offersLoading = false;
        });

        if (offers.length == 0) {
          return;
        }

        setState(() {
          _offers.addAll(offers);
        });
      },
      onError: (response) {
        if (!mounted) return;

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

  _loadMerchants() {
    _merchantsLoading = true;

    MerchantServices().index(
      limit: 6,
      page: 1,
      onSuccess: (List<Merchant> merchants, page) {
        if (!mounted) return;

        setState(() {
          _merchantsLoading = false;
        });

        if (merchants.length == 0) {
          return;
        }

        setState(() {
          _merchants.addAll(merchants);
        });
      },
      onError: (response) {
        if (!mounted) return;

        setState(() {
          _merchantsLoading = false;
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
    final _size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: MySliverAppBar(
              expandedHeight: 250, auth: _auth, currentPoints: _currentPoints),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.03 * _size.width,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Latest',
                              style: TextStyle(fontSize: 22.0),
                            ),
                            TextSpan(
                              text: ' Rewards',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      primaryButton(
                        text: 'View More',
                        color: _theme.primaryColor,
                        style: _theme.textTheme.button,
                        width: 100,
                        padding: paddingSmall,
                        onClick: () {
                          Navigator.pushNamed(context, '/coupons-list');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              _offersLoading == true
                  ? Center(
                      child: SpinKitPouringHourglass(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : _offers.length == 0
                      ? Center(
                          child: Text(
                            'No results found',
                            style: _theme.textTheme.headline3,
                          ),
                        )
                      : FadeAnimation(
                          1,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0.03 * _size.width),
                            height: 270,
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: _offers.length,
                              itemBuilder: (context, index) {
                                return CouponCard(
                                  offer: _offers[index],
                                  press: () => Navigator.pushNamed(
                                      context, '/coupon-detail',
                                      arguments: _offers[index]),
                                );
                              },
                            ),
                          ),
                        ),
              SizedBox(height: spacingSmall),
              FadeAnimation(
                1,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.03 * _size.width,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'New',
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              TextSpan(
                                text: ' Shops',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1,
                        primaryButton(
                          text: 'View More',
                          color: _theme.primaryColor,
                          style: _theme.textTheme.button,
                          width: 100,
                          padding: paddingSmall,
                          onClick: () {
                            Navigator.pushNamed(context, '/categories');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              _merchantsLoading == true
                  ? Center(
                      child: SpinKitPouringHourglass(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : _merchants.length == 0
                      ? Center(
                          child: Text(
                            'No results found',
                            style: _theme.textTheme.headline3,
                          ),
                        )
                      : FadeAnimation(
                          1,
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 400.0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 4),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 1200),
                              autoPlayCurve: Curves.easeInOutBack,
                            ),
                            items: _merchants.map((merchant) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  width: MediaQuery.of(context).size.width,
                                  child: MerchantCard(
                                    merchant: merchant,
                                    press: () => Navigator.pushNamed(
                                      context,
                                      '/merchant-detail',
                                      arguments: merchant,
                                    ),
                                  ),
                                );
                              });
                            }).toList(),
                          ),
                        ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ],
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Auth auth;
  final int currentPoints;

  MySliverAppBar(
      {@required this.expandedHeight,
      @required this.auth,
      @required this.currentPoints});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: double.infinity,
          color: _theme.primaryColor,
          child: Image.asset(
            'assets/images/home.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8),
              Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: _theme.accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    MaterialCommunityIcons.leaf,
                    color: _theme.primaryColor,
                    size: 28,
                  ),
                ),
              ),
              SizedBox(height: 10),
              FadeAnimation(
                1,
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline2,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Your ',
                        style: TextStyle(fontWeight: FontWeight.w100),
                      ),
                      TextSpan(
                        text: 'Points',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              FadeAnimation(
                1,
                Text(
                  currentPoints.toString(),
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 0.75),
                )
              ],
              color: _theme.accentColor,
            ),
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: _theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  MaterialCommunityIcons.leaf,
                  color: _theme.accentColor,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 1.5 - shrinkOffset,
          left: _size.width / 40,
          width: 0.95 * _size.width,
          height: 80,
          child: FadeAnimation(
            1,
            AnimatedOpacity(
              opacity: shrinkOffset == 0 ? 1 : 0,
              duration: Duration(milliseconds: 200),
              // opacity: (1 - shrinkOffset / expandedHeight),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(context, '/categories'),
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  MaterialIcons.store,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Shops',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                '/qr-code',
                                arguments: auth,
                              ),
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  FontAwesome.qrcode,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'QR Code',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                '/classification',
                              ),
                            },
                            child: Container(
                              child: Column(children: <Widget>[
                                Icon(
                                  FontAwesome.camera_retro,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Scanner',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.pushNamed(
                                context,
                                '/guide-categories',
                              ),
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Entypo.open_book,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Guides',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: <Widget>[
                      //     GestureDetector(
                      //       onTap: () => {
                      //         Navigator.pushNamed(
                      //           context,
                      //           '/guide-categories',
                      //         ),

                      //       },
                      //       child: Column(
                      //         children: <Widget>[
                      //           Icon(
                      //             Entypo.open_book,
                      //             color: Theme.of(context).primaryColor,
                      //             size: 30,
                      //           ),
                      //           SizedBox(height: 5),
                      //           Text(
                      //             'Guides',
                      //             style: TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () => Auth.erase(),
                      //       child: Column(
                      //         children: <Widget>[
                      //           Icon(
                      //             Entypo.wallet,
                      //             color: Theme.of(context).primaryColor,
                      //             size: 30,
                      //           ),
                      //           SizedBox(height: 5),
                      //           Text(
                      //             'Wallet',
                      //             style: TextStyle(
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
