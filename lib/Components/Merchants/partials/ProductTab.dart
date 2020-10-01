import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zwm_app/Components/Products/product_detail.dart';
import 'package:zwm_app/Models/Product.dart';
import 'package:zwm_app/constants.dart';

class ProductTab extends StatefulWidget {
  final String name;
  final List<Product> products;

  const ProductTab({@required this.name, @required this.products});

  ProductTabState createState() => ProductTabState();
}

class ProductTabState extends State<ProductTab> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      color: accentColor,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: spacingSmall),
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
          widget.products.length == 0
              ? Text(
                  'No items for now',
                  style: _theme.textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: tertiaryColor,
                  ),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.1 / 2.9,
                  crossAxisSpacing: paddingLarge,
                  children: widget.products.map<Widget>((Product product) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/product-detail',
                        arguments: ProductDetail(product: product),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: product.photo,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 140,
                              ),
                            ),
                            Container(
                              height: 70,
                              padding:
                                  EdgeInsets.fromLTRB(0, paddingSmall, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      "${product.name}\n",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          _theme.textTheme.bodyText1.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Flexible(
                                    child: Text(
                                      'RM ${product.price}',
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
          // SizedBox(height: spacingMid),
          // Container(height: spacingSmall, color: Colors.grey[200]),
        ],
      ),
    );
  }
}
