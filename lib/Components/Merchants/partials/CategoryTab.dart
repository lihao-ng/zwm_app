import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Offer.dart';

class CategoryTab extends StatefulWidget {
  CategoryTabState createState() => CategoryTabState();
}

class CategoryTabState extends State<CategoryTab>
    with AutomaticKeepAliveClientMixin<CategoryTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 180 / 280,
      children: offers.map<Widget>((Offer offer) {
        return GestureDetector(
          // onTap: press,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
              width: 180,
              height: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    offer.photo,
                    fit: BoxFit.fill,
                    width: 180,
                    height: 180,
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(10),
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
                            style: _theme.textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
