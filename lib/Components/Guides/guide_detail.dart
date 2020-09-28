import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Guide.dart';
import 'package:zwm_app/constants.dart';

class GuideDetail extends StatefulWidget {
  final Guide guide;

  const GuideDetail({@required this.guide});

  @override
  _GuideDetailState createState() => _GuideDetailState();
}

class _GuideDetailState extends State<GuideDetail> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: _size.width,
              height: 50,
              alignment: Alignment.centerLeft,
              color: widget.guide.recyclable == 'Recyclable'
                  ? primaryColor
                  : Colors.red[700],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: spacingMid),
                  Icon(
                    widget.guide.recyclable == 'Recyclable'
                        ? Icons.check
                        : Icons.close,
                    size: 30.0,
                    color: accentColor,
                  ),
                  SizedBox(width: spacingSmall),
                  Text(
                    'Your item is ' + widget.guide.recyclable,
                    style: _theme.textTheme.headline3.copyWith(
                      color: accentColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(paddingMid),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: spacingSmall),
                  Text(
                    widget.guide.name,
                    style: _theme.textTheme.headline1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: spacingMin),
                  Text(
                    widget.guide.category,
                    style: _theme.textTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spacingMid),
                  ReadMoreText(
                    widget.guide.description,
                    trimLines: 6,
                    style: _theme.textTheme.bodyText1.copyWith(
                      color: tertiaryColor,
                    ),
                    colorClickableText: primaryColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: ' show less',
                  ),
                  SizedBox(height: spacingSmall),
                  ExpandableNotifier(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                          ScrollOnExpand(
                            scrollOnExpand: true,
                            scrollOnCollapse: false,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                              ),
                              header: Padding(
                                padding: EdgeInsets.all(paddingMid),
                                child: Text(
                                  "ExpandablePanel",
                                  style: _theme.textTheme.headline3
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              collapsed: Text(
                                widget.guide.description,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.bodyText1.copyWith(
                                  color: tertiaryColor,
                                ),
                              ),
                              expanded: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: paddingMid),
                                    child: Text(
                                      widget.guide.description,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        color: tertiaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: paddingMid,
                                    right: paddingMid,
                                    bottom: paddingMid,
                                  ),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(
                                      crossFadePoint: 0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ExpandableNotifier(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                          ScrollOnExpand(
                            scrollOnExpand: true,
                            scrollOnCollapse: false,
                            child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment:
                                    ExpandablePanelHeaderAlignment.center,
                                tapBodyToCollapse: true,
                              ),
                              header: Padding(
                                padding: EdgeInsets.all(paddingMid),
                                child: Text(
                                  "ExpandablePanel",
                                  style: _theme.textTheme.headline3
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              collapsed: Text(
                                widget.guide.description,
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.bodyText1.copyWith(
                                  color: tertiaryColor,
                                ),
                              ),
                              expanded: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: paddingMid),
                                    child: Text(
                                      widget.guide.description,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        color: tertiaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              builder: (_, collapsed, expanded) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: paddingMid,
                                    right: paddingMid,
                                    bottom: paddingMid,
                                  ),
                                  child: Expandable(
                                    collapsed: collapsed,
                                    expanded: expanded,
                                    theme: const ExpandableThemeData(
                                      crossFadePoint: 0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
