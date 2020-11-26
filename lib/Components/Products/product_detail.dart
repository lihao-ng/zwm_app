import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Models/Product.dart';
import 'package:zwm_app/Services/MerchantServices.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  final bool redirect;

  const ProductDetail({@required this.product, this.redirect: false});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
  }

  void _onVisit() {
    processingDialog(context);

    MerchantServices().show(
      id: widget.product.merchantId,
      onSuccess: (Merchant merchant) {
        Navigator.of(context).pop();
        Keys.navKey.currentState
            .pushNamed('/merchant-detail', arguments: merchant);
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.product.photo,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
              SizedBox(height: spacingMin),
              Padding(
                padding: EdgeInsets.all(paddingMid),
                child: Column(
                  children: [
                    Text(
                      widget.product.name,
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
                                'Price',
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: tertiaryColor,
                                ),
                              ),
                              SizedBox(height: spacingMin),
                              Text(
                                "RM " + widget.product.price.toString(),
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          VerticalDivider(thickness: 2),
                          Column(
                            children: [
                              Text(
                                'Category',
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: tertiaryColor,
                                ),
                              ),
                              SizedBox(height: spacingMin),
                              Text(
                                widget.product.category,
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
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
                      widget.product.description,
                      style: _theme.textTheme.bodyText1.copyWith(
                        color: tertiaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: widget.redirect,
          child: Padding(
            padding: EdgeInsets.all(paddingMid),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: paddingLarge),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onPressed: () {
                _onVisit();
              },
              color: primaryColor,
              textColor: accentColor,
              child: Text('Visit Shop'),
            ),
          ),
        ),
      ),
    );
  }
}
