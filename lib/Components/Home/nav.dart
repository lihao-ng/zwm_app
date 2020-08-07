import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zwm_app/Components/Home/partials/home.dart';
import 'package:zwm_app/Components/Home/partials/virtual_world.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _page = 0;
  GlobalKey _bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final _pages = [
      Home(),
      VirtualWorld(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).accentColor,
        ),
        title: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            MaterialCommunityIcons.leaf,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
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
            MaterialIcons.directions_walk,
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
    );
  }
}
