import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Merchant.dart';

class MerchantCard extends StatelessWidget {
  final Merchant merchant;
  final Function press;

  const MerchantCard({
    Key key,
    this.merchant,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                merchant.image,
                fit: BoxFit.fill,
                width: _size.width,
                height: 280,
              ),
              Container(
                height: 110,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "${merchant.name}\n",
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Address: ${merchant.address}',
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.caption,
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        'Category: ${merchant.category}',
                        overflow: TextOverflow.ellipsis,
                        style: _theme.textTheme.caption,
                      ),
                    ),
                    SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        'Contact: ${merchant.contact}',
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
  }
}
