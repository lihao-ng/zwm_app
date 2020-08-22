import 'package:flutter/material.dart';

import 'package:zwm_app/Components/Widgets/Logo.dart';
import 'package:zwm_app/constants.dart';

Widget appBar({hasSideIcon = true}) {
  return AppBar(
    backgroundColor: accentColor,
    automaticallyImplyLeading: hasSideIcon,
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    title: logo(),
    centerTitle: true,
  );
}

Widget customAppBar() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tertiaryColor,
          blurRadius: 5.0,
          offset: Offset(0.0, 0.75),
        )
      ],
      color: accentColor,
    ),
    child: Center(child: logo()),
  );
}

class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}

class _SABTState extends State<SABT> {
  ScrollPosition _position;
  bool _visible;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings = context
        .dependOnInheritedWidgetOfExactType(aspect: FlexibleSpaceBarSettings);
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: widget.child,
    );
  }
}
