import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        title,
                        style: _theme.textTheme.headline3.copyWith(
                          color: tertiaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        body,
                        style: _theme.textTheme.bodyText1.copyWith(
                          color: tertiaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.all(paddingMid),
                        child: primaryButton(
                          text: 'OK',
                          color: Colors.red,
                          style: _theme.textTheme.button,
                          onClick: () => Navigator.of(context).pop(),
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
                    'assets/images/errors/error.png',
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
