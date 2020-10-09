import 'package:flutter/material.dart';
import 'package:zwm_app/Animations/FadeAnimation.dart';
import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/constants.dart';

class BusinessHoursDialog extends StatelessWidget {
  final String businessHours;

  BusinessHoursDialog({
    this.businessHours,
  });

  @override
  Widget build(BuildContext context) {
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
                      'Business Hours',
                      style: _theme.textTheme.headline3.copyWith(
                        color: tertiaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 100,
                      child: SingleChildScrollView(
                        child: Text(
                          businessHours != null ? businessHours : 'No mention',
                          style: _theme.textTheme.bodyText1.copyWith(
                            color: tertiaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(paddingMid),
                      child: primaryButton(
                        text: 'OK',
                        color: primaryColor,
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
                  'assets/images/errors/clock.png',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
