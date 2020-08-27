import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:countup/countup.dart';

import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Components/Nav/partials/home/CouponCard.dart';
import 'package:zwm_app/Components/Nav/partials/home/MerchantCard.dart';
import 'package:zwm_app/Models/Auth.dart';
import 'package:zwm_app/Models/Coupon.dart';
import 'package:zwm_app/Models/Merchant.dart';

import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: MySliverAppBar(expandedHeight: 320),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
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
                        padding: 11.0,
                        onClick: () {
                          Navigator.pushNamed(context, '/coupons-list');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              FadeAnimation(
                1,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0.03 * _size.width),
                  height: 270,
                  width: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return CouponCard(
                        coupon: coupons[index],
                        press: () => {},
                        // press: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => DetailsScreen(
                        //         product: products[index],
                        //       ),
                        //     )),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
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
                                text: 'Popular',
                                style: TextStyle(fontSize: 22.0),
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
                          padding: 11.0,
                          onClick: () {
                            // emailController.text
                            // get value and request for auth

                            Navigator.pushNamed(context, '/categories');
                            // Navigator.pushNamed(context, '/nav');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              FadeAnimation(
                1,
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    autoPlayAnimationDuration: Duration(milliseconds: 1200),
                    autoPlayCurve: Curves.easeInOutBack,
                  ),
                  items: merchants.map((merchant) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        child: MerchantCard(
                          merchant: merchant,
                          press: () =>
                              {debugPrint('merchant id: ${merchant.id}')},
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  var _points = 75000;

  MySliverAppBar({@required this.expandedHeight});

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
            'assets/images/home_bg.jpg',
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
                  _points.toString(),
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
              // Countup(
              //   begin: _points - 5000,
              //   end: _points,
              //   duration: Duration(milliseconds: 1000),
              //   separator: ',',
              // style: TextStyle(
              //   fontSize: 36,
              // ),
              // ),
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
          top: expandedHeight / 2.3 - shrinkOffset,
          left: _size.width / 40,
          width: 0.95 * _size.width,
          height: 160,
          child: FadeAnimation(
            1,
            Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
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
                                  'Categories',
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
                              Navigator.pushNamed(context, '/qr-code'),
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
                          Container(
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
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
                          GestureDetector(
                            onTap: () => {
                              Auth.erase(done: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login',
                                  (Route<dynamic> route) => false,
                                );
                              })
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Entypo.wallet,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Wallet',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
