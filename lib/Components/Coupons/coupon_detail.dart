import 'package:flutter/material.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Coupon.dart';
import 'package:zwm_app/constants.dart';

class CouponDetail extends StatefulWidget {
  final Coupon coupon;

  const CouponDetail({@required this.coupon});

  @override
  _CouponDetailState createState() => _CouponDetailState();
}

class _CouponDetailState extends State<CouponDetail>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: SABT(
                  child: Text(
                    widget.coupon.title,
                    style: _theme.textTheme.headline3,
                  ),
                ),
                leading: IconButton(
                  icon: ClipOval(
                    child: Material(
                      color: accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(paddingSmall),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                titleSpacing: 0,
                backgroundColor: accentColor,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.asset(widget.coupon.image, fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(paddingMid),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: spacingMin),
                          Text(
                            widget.coupon.title,
                            style: _theme.textTheme.headline3,
                          ),
                          SizedBox(height: spacingSmall),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Points',
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: tertiaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spacingMin),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                widget.coupon.price.toString(),
                                            style: _theme.textTheme.bodyText1
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " points",
                                            style: _theme.textTheme.caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                VerticalDivider(thickness: 2),
                                Column(
                                  children: [
                                    Text(
                                      'Validity',
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: tertiaryColor,
                                      ),
                                    ),
                                    SizedBox(height: spacingMin),
                                    Text(
                                      '30 Dec 2020',
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        color: tertiaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: spacingMin),
                          Divider(thickness: 2),
                          SizedBox(height: spacingMin),
                          Text(
                            'Description',
                            style: _theme.textTheme.headline3.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                          Text(
                            widget.coupon.description,
                            style: _theme.textTheme.bodyText1.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                          Divider(thickness: 2),
                          SizedBox(height: spacingMin),
                          Text(
                            'Terms & Conditions',
                            style: _theme.textTheme.headline3.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                          Text(
                            widget.coupon.description,
                            style: _theme.textTheme.bodyText1.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                          SizedBox(height: spacingSmall),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(paddingMid),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: paddingLarge),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {},
            color: primaryColor,
            textColor: accentColor,
            child: Text('Redeem Now'),
          ),
        ),
      ),
    );
  }
}
