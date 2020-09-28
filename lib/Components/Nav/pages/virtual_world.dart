import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Services/AuthServices.dart';
import 'package:zwm_app/constants.dart';

class VirtualWorld extends StatefulWidget {
  VirtualWorld({Key key}) : super(key: key);

  @override
  _VirtualWorldState createState() => _VirtualWorldState();
}

class _VirtualWorldState extends State<VirtualWorld> {
  String animationName = 'walking';
  int _totalPoints = 0;
  int _currentPoints = 0;

  int _startValue = 0;
  int _endValue = 1000;

  String _flareFile = '';

  _loadAccount() {
    AuthServices().updatePoints(
      onSuccess: (totalPoints, currentPoints) {
        setState(() {
          _totalPoints = totalPoints;

          if (_totalPoints < 1000) {
            _currentPoints = _totalPoints;
            _flareFile = 'assets/images/girl_walking.flr';
          } else if (_totalPoints >= 1000 && _totalPoints < 2000) {
            _currentPoints = _totalPoints - 1000;
            _startValue = 1000;
            _endValue = 2000;
            _flareFile = 'assets/images/girl_walking_2.flr';
          } else if (_totalPoints >= 2000) {
            _flareFile = 'assets/images/girl_walking_3.flr';
          }
        });
      },
      onError: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(hasSideIcon: false),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.all(paddingMid),
                child: Container(
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
                          _flareFile != ''
                              ? SizedBox(
                                  width: _size.width,
                                  height: 20,
                                  child: _totalPoints >= 2000
                                      ? Center(
                                          child: Text(
                                            "You're doing great! Keep it up!",
                                            style: _theme.textTheme.caption
                                                .copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : LiquidLinearProgressIndicator(
                                          value: _currentPoints / 1000,
                                          valueColor: AlwaysStoppedAnimation(
                                              primaryColor),
                                          backgroundColor: accentColor,
                                          borderColor: primaryColor,
                                          borderWidth: 2,
                                          direction: Axis.horizontal,
                                        ),
                                )
                              : Center(
                                  child: SpinKitPouringHourglass(
                                    color: Theme.of(context).primaryColor,
                                    size: 50.0,
                                  ),
                                ),
                          SizedBox(height: 3),
                          if (_flareFile != '' && _totalPoints < 2000)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(_startValue.toString(),
                                    style: _theme.textTheme.caption),
                                Text(
                                  _currentPoints.toString() + ' / 1000 points',
                                  style: _theme.textTheme.caption.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(_endValue.toString(),
                                    style: _theme.textTheme.caption)
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
            ),
            _flareFile != ''
                ? Container(
                    width: _size.width,
                    height: 300,
                    child: FlareActor(
                      _flareFile,
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: animationName,
                    ),
                  )
                : Center(
                    child: SpinKitPouringHourglass(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
