import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:zwm_app/Components/Nav/pages/home.dart';
import 'package:zwm_app/Components/Nav/pages/location_map.dart';
import 'package:zwm_app/Components/Nav/pages/virtual_world.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  GlobalKey _bottomNavKey = GlobalKey();
  int _page = 0;

  final _pages = [
    Home(),
    VirtualWorld(),
    LocationMap(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
          height: 60.0,
          animationDuration: Duration(milliseconds: 300),
          key: _bottomNavKey,
          items: <Widget>[
            Icon(
              FontAwesome.home,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              MaterialCommunityIcons.trophy,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              FontAwesome.map_marker,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
            Icon(
              FontAwesome.user_circle_o,
              size: 30,
              color: Theme.of(context).accentColor,
            )
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _pages[_page],
      ),
    );
  }
}
