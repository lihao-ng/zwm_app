import 'package:flutter/material.dart';

class VirtualWorld extends StatefulWidget {
  VirtualWorld({Key key}) : super(key: key);

  @override
  _VirtualWorldState createState() => _VirtualWorldState();
}

class _VirtualWorldState extends State<VirtualWorld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('VirtualWorld'),
    );
  }
}
