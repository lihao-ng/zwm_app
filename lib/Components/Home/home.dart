import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        title: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            MaterialCommunityIcons.leaf,
            color: Theme.of(context).accentColor,
            size: 28,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColor,
        height: 60.0,
        animationDuration: Duration(milliseconds: 300),
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
          Icon(
            Icons.compare_arrows,
            size: 30,
            color: Theme.of(context).accentColor,
          )
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            Navigator.pushNamed(context, '/register');
          });
        },
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_page.toString(), textScaleFactor: 10.0),
              RaisedButton(
                child: Text('Go To Page of index 1'),
                onPressed: () {
                  //Page change using state does the same as clicking index 1 navigation button
                  final CurvedNavigationBarState navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState.setPage(1);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
