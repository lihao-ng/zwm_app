import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Components/Widgets/Buttons/PrimaryButton.dart';
import 'package:zwm_app/Models/Classify.dart';
import 'package:zwm_app/Models/Guide.dart';
import 'package:zwm_app/Services/GuideServices.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class ClassificationResult extends StatefulWidget {
  final List<Classify> classifications;
  final String imagePath;

  const ClassificationResult({Key key, this.classifications, this.imagePath})
      : super(key: key);

  @override
  _ClassificationResult createState() => _ClassificationResult();
}

class _ClassificationResult extends State<ClassificationResult> {
  _showResultsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _theme = Theme.of(context);

        return AlertDialog(
          title: Text(
            'Results',
            style: _theme.textTheme.headline1,
          ),
          content: Container(
            width: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.classifications.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: spacingMid),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.classifications[index].label,
                        style: _theme.textTheme.bodyText1.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: spacingMin),
                    Center(
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 130,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 1000,
                        percent: double.parse(
                          widget.classifications[index].confidence
                              .toStringAsFixed(1),
                        ),
                        center: Text(
                          widget.classifications[index]
                              .getPercentage()
                              .toStringAsFixed(2),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: index == 0
                            ? primaryColor
                            : Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _onLearnMore() {
    processingDialog(context);

    GuideServices().index(
      search: widget.classifications[0].label,
      page: 1,
      limit: 1,
      onSuccess: (List<Guide> guides, page) {
        Navigator.of(context).pop();

        if (guides.length == 0) {
          errorAlert(
            context,
            title: "An error has occured!",
            body: "Could not find results in our database",
          );

          return;
        }

        Keys.navKey.currentState.pushReplacementNamed(
          '/guide-detail',
          arguments: guides[0],
        );
      },
      onError: (response) {
        Navigator.of(context).pop();
        errorAlert(
          context,
          title: "An error has occured!",
          body: response,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: _size.width,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: _size.width,
              color: accentColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: paddingMid,
                  horizontal: paddingMid,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ZWM identifies this object as a:',
                      style: _theme.textTheme.bodyText1.copyWith(
                        color: tertiaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spacingSmall),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: paddingSmall),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.classifications[0].label,
                              style: _theme.textTheme.headline3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _showResultsDialog(),
                            child: Row(
                              children: [
                                Text(
                                  "View Results",
                                  style: _theme.textTheme.bodyText1.copyWith(
                                    color: tertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Foundation.graph_horizontal),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: spacingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            Keys.navKey.currentState.pushReplacementNamed(
                              '/classification',
                            )
                          },
                          child: Text(
                            'Try Again',
                            style: _theme.textTheme.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spacingSmall),
                        primaryButton(
                          text: 'Learn More',
                          color: Theme.of(context).primaryColor,
                          style: Theme.of(context).textTheme.button,
                          width: 100,
                          padding: paddingSmall,
                          onClick: () => {_onLearnMore()},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
