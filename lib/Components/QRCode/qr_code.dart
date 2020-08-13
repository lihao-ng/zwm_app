import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/constants.dart';

class QrCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                1,
                RichText(
                  text: TextSpan(
                    style: _theme.textTheme.headline1,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Qr ',
                      ),
                      TextSpan(
                        text: 'Code',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spacingMin),
              FadeAnimation(
                1.3,
                Text(
                  'Show this QR Code to the staff/cashier',
                  style: _theme.textTheme.caption,
                ),
              ),
              SizedBox(height: spacingSmall),
              FadeAnimation(
                1.5,
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.all(paddingMid),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/qr_placeholder.jpg',
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: spacingSmall),
                        Text(
                            'In case QR Code is not working or scanner is unavailable, please use the code below.',
                            style: _theme.textTheme.caption),
                        SizedBox(height: spacingSmall),
                        Center(
                          child: Text(
                            'e10d1dd923d0',
                            style: _theme.textTheme.caption.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
