import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:countup/countup.dart';

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

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 0.25 * _size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                color: _theme.primaryColor,
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: <Widget>[
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
                    SizedBox(height: 20),
                    FadeAnimation(
                      1.4,
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 15,
                              spreadRadius: -13,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
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
