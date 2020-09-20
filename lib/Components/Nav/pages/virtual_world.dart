import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/constants.dart';

class VirtualWorld extends StatefulWidget {
  VirtualWorld({Key key}) : super(key: key);

  @override
  _VirtualWorldState createState() => _VirtualWorldState();
}

class _VirtualWorldState extends State<VirtualWorld> {
  String animationName = 'walking';

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(hasSideIcon: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingMid),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                1,
                Container(
                  width: _size.width,
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              style: _theme.textTheme.headline1,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'ZW ',
                                ),
                                TextSpan(
                                  text: 'Progress',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: spacingSmall),
                          SizedBox(
                            width: _size.width,
                            height: 20,
                            child: LiquidLinearProgressIndicator(
                              value: 50 / 1000,
                              valueColor: AlwaysStoppedAnimation(primaryColor),
                              backgroundColor: accentColor,
                              borderColor: primaryColor,
                              borderWidth: 2,
                              direction: Axis.horizontal,
                              // center: Text("Loading..."),
                            ),
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('0', style: _theme.textTheme.caption),
                              Text(
                                '50 / 1000 points',
                                style: _theme.textTheme.caption.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('1000', style: _theme.textTheme.caption)
                            ],
                          ),
                          SizedBox(height: spacingMid),
                          Text(
                            'Keep collecting points to change the world below!',
                            style: _theme.textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.2,
                Container(
                  // elevation: 3,
                  width: _size.width,
                  height: 300,
                  child: FlareActor(
                    'assets/images/girl_walking.flr',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: animationName,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
