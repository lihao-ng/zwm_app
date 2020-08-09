import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:countup/countup.dart';
import 'package:zwm_app/Components/Home/partials/home/CouponCard.dart';
import 'package:zwm_app/Models/Coupon.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _points = 75000;

  String i;
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
          delegate: MySliverAppBar(expandedHeight: 200),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 130),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03 * _size.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1.2,
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline1,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Latest',
                              style: TextStyle(fontWeight: FontWeight.w100),
                            ),
                            TextSpan(
                              text: ' Rewards',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              for (var index = 0; index < coupons.length; index++)
                SizedBox(
                  height: 200,
                  child: CouponCard(
                    coupon: coupons[index],
                    press: () => {},
                    // press: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => DetailsScreen(
                    //         product: products[index],
                    //       ),
                    //     )),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  var _points = 75000.00;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          height: 0.35 * _size.height,
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
                1.2,
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
              Countup(
                begin: _points - 5000,
                end: _points,
                duration: Duration(milliseconds: 1200),
                separator: ',',
                style: TextStyle(
                  fontSize: 36,
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
          top: expandedHeight / 1.3 - shrinkOffset,
          left: _size.width / 40,
          width: 0.95 * _size.width,
          height: 160,
          child: FadeAnimation(
            1.5,
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
                          Container(
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
                          Container(
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
                          Container(
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
