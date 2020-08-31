import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/Models/Promocode.dart';
import 'package:zwm_app/Services/PromocodeServices.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class CouponDetail extends StatefulWidget {
  final Offer offer;

  const CouponDetail({@required this.offer});

  @override
  _CouponDetailState createState() => _CouponDetailState();
}

class _CouponDetailState extends State<CouponDetail> {
  @override
  void initState() {
    super.initState();
  }

  void _onRedeem() {
    processingDialog(context);

    PromocodeServices().redeem(
      offerId: widget.offer.id,
      onSuccess: (Promocode promocode) {
        if (offers.length == 0) {
          return;
        }

        Keys.navKey.currentState
            .pushNamed('/promocode-detail', arguments: promocode);
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

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: Hero(
            tag: 'hero-' + widget.offer.id.toString(),
            flightShuttleBuilder: (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return SingleChildScrollView(
                child: fromHeroContext.widget,
              );
            },
            child: Material(
              type: MaterialType.transparency,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: widget.offer.photo,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: spacingMin),
                    Padding(
                      padding: EdgeInsets.all(paddingMid),
                      child: Column(
                        children: [
                          Text(
                            widget.offer.name,
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
                                                widget.offer.points.toString(),
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
                            widget.offer.description,
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
                            widget.offer.description,
                            style: _theme.textTheme.bodyText1.copyWith(
                              color: tertiaryColor,
                            ),
                          ),
                          SizedBox(height: spacingSmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

            // child: Flexible(
            //   child: CustomScrollView(
            //     slivers: <Widget>[
            //       SliverAppBar(
            //         title: SABT(
            //           child: Text(
            //             widget.offer.name,
            //             style: _theme.textTheme.headline3,
            //           ),
            //         ),
            //         leading: IconButton(
            //           icon: ClipOval(
            //             child: Material(
            //               color: accentColor,
            //               child: Padding(
            //                 padding: EdgeInsets.all(paddingSmall),
            //                 child: Icon(
            //                   Icons.arrow_back,
            //                   color: primaryColor,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           onPressed: () => Navigator.of(context).pop(),
            //         ),
            //         titleSpacing: 0,
            //         backgroundColor: accentColor,
            //         expandedHeight: 200.0,
            //         pinned: true,
            //         flexibleSpace: FlexibleSpaceBar(
            //           background:
            //               Image.network(widget.offer.photo, fit: BoxFit.cover),
            //         ),
            //       ),
            //       SliverList(
            //         delegate: SliverChildListDelegate(
            //           [
            //             Padding(
            //               padding: EdgeInsets.all(paddingMid),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   SizedBox(height: spacingMin),
            //                   Text(
            //                     widget.offer.name,
            //                     style: _theme.textTheme.headline3,
            //                   ),
            //                   SizedBox(height: spacingSmall),
            //                   IntrinsicHeight(
            //                     child: Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Column(
            //                           children: [
            //                             Text(
            //                               'Points',
            //                               style: _theme.textTheme.bodyText1
            //                                   .copyWith(
            //                                 fontWeight: FontWeight.bold,
            //                                 color: tertiaryColor,
            //                               ),
            //                             ),
            //                             SizedBox(height: spacingMin),
            //                             RichText(
            //                               overflow: TextOverflow.ellipsis,
            //                               text: TextSpan(
            //                                 style: DefaultTextStyle.of(context)
            //                                     .style,
            //                                 children: <TextSpan>[
            //                                   TextSpan(
            //                                     text: widget.offer.points
            //                                         .toString(),
            //                                     style: _theme
            //                                         .textTheme.bodyText1
            //                                         .copyWith(
            //                                       fontWeight: FontWeight.bold,
            //                                     ),
            //                                   ),
            //                                   TextSpan(
            //                                     text: " points",
            //                                     style: _theme.textTheme.caption,
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         VerticalDivider(thickness: 2),
            //                         Column(
            //                           children: [
            //                             Text(
            //                               'Validity',
            //                               style: _theme.textTheme.bodyText1
            //                                   .copyWith(
            //                                 fontWeight: FontWeight.bold,
            //                                 color: tertiaryColor,
            //                               ),
            //                             ),
            //                             SizedBox(height: spacingMin),
            //                             Text(
            //                               '30 Dec 2020',
            //                               style: _theme.textTheme.bodyText1
            //                                   .copyWith(
            //                                 color: tertiaryColor,
            //                               ),
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                   SizedBox(height: spacingMin),
            //                   Divider(thickness: 2),
            //                   SizedBox(height: spacingMin),
            //                   Text(
            //                     'Description',
            //                     style: _theme.textTheme.headline3.copyWith(
            //                       color: tertiaryColor,
            //                     ),
            //                   ),
            //                   Text(
            //                     widget.offer.description,
            //                     style: _theme.textTheme.bodyText1.copyWith(
            //                       color: tertiaryColor,
            //                     ),
            //                   ),
            //                   Divider(thickness: 2),
            //                   SizedBox(height: spacingMin),
            //                   Text(
            //                     'Terms & Conditions',
            //                     style: _theme.textTheme.headline3.copyWith(
            //                       color: tertiaryColor,
            //                     ),
            //                   ),
            //                   Text(
            //                     widget.offer.description,
            //                     style: _theme.textTheme.bodyText1.copyWith(
            //                       color: tertiaryColor,
            //                     ),
            //                   ),
            //                   SizedBox(height: spacingSmall),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(paddingMid),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: paddingLarge),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              _onRedeem();
            },
            color: primaryColor,
            textColor: accentColor,
            child: Text('Redeem Now'),
          ),
        ),
      ),
    );
  }
}
