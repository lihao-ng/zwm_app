import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Offer.dart';
import 'package:zwm_app/constants.dart';

class AcceptingItemsTab extends StatefulWidget {
  final String name;

  const AcceptingItemsTab({@required this.name});

  AcceptingItemsTabState createState() => AcceptingItemsTabState();
}

class AcceptingItemsTabState extends State<AcceptingItemsTab> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(paddingMid),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: _theme.textTheme.headline3,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          SizedBox(height: spacingSmall),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2.1 / 2.9,
            crossAxisSpacing: paddingLarge,
            children: offers.map<Widget>((Offer offer) {
              return GestureDetector(
                // onTap: press,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          offer.photo,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 140,
                        ),
                      ),
                      Container(
                        height: 70,
                        padding: EdgeInsets.fromLTRB(0, paddingSmall, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "${offer.name}\n",
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Flexible(
                              child: Text(
                                '${offer.points} points',
                                overflow: TextOverflow.ellipsis,
                                style: _theme.textTheme.caption.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: spacingMid),
          Container(height: spacingSmall, color: Colors.grey[200]),
        ],
      ),
    );
  }
}
