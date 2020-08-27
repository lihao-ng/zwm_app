import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/constants.dart';

Future<void> errorAlert(BuildContext context, {title, body}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      final _theme = Theme.of(context);

      return FadeAnimation(
        0.5,
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: [
              Container(
                height: 300,
                child: Padding(
                  padding: EdgeInsets.all(paddingSmall),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        title,
                        style: _theme.textTheme.headline3.copyWith(
                          color: tertiaryColor,
                        ),
                      ),
                      Text(
                        body,
                        style: _theme.textTheme.bodyText1.copyWith(
                          color: tertiaryColor,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(paddingMid),
                        width: double.infinity,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: paddingLarge),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.red,
                          textColor: accentColor,
                          child: Text('OK'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -40,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                    'assets/images/error.png',
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future<void> processingDialog(BuildContext context,
    {String title = "Hold on"}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: SpinKitPouringHourglass(
                  color: accentColor,
                  size: 50.0,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
