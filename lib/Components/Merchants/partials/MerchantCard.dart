import 'package:flutter/material.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/constants.dart';

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
      behavior: HitTestBehavior.translucent,
      onTap: press,
      child: Container(
        width: _size.width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      merchant.name,
                      style: _theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tertiaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      merchant.category,
                      style: _theme.textTheme.caption,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spacingMin),
                    Text(
                      merchant.address,
                      style: _theme.textTheme.caption.copyWith(
                        color: tertiaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: spacingSmall),
                    Text(
                      merchant.contact,
                      style: _theme.textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                merchant.image,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
