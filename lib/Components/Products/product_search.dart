import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Product.dart';
import 'package:zwm_app/Services/ProductServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/screens.dart';
import 'package:zwm_app/utils.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List<Product> _products = [];

  bool _loading = true;

  String _searchValue = '';
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  _loadGuides({search = false}) {
    _loading = true;

    ProductServices().index(
      search: _searchValue,
      limit: 100,
      onSuccess: (List<Product> products) {
        setState(() {
          if (search == true) {
            _products.clear();
          }

          _products.addAll(products);

          _loading = false;
        });
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

  _filterSearchResults(String query) {
    setState(() {
      _searchValue = query;
    });

    _loadGuides(search: true);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(paddingMid),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Search Products',
              style: _theme.textTheme.headline1,
            ),
            SizedBox(height: spacingSmall),
            TextField(
              controller: searchController,
              onChanged: (value) {
                _filterSearchResults(value);
              },
              decoration: InputDecoration(
                fillColor: accentColor,
                filled: true,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingMid + 2,
                  horizontal: paddingMid,
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search object or material',
                hintStyle: TextStyle(height: 1.5),
              ),
            ),
            SizedBox(height: spacingMid),
            Expanded(
              child: _loading == true
                  ? Center(
                      child: SpinKitPouringHourglass(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : _products.length == 0
                      ? Center(
                          child: Text(
                            'No results found.',
                            style: _theme.textTheme.headline3,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: paddingSmall,
                          ),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 2.1 / 2.9,
                            crossAxisSpacing: paddingLarge,
                            mainAxisSpacing: paddingLarge,
                            children: _products.map((Product product) {
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.pushNamed(
                                    context,
                                    '/product-detail',
                                    arguments: ProductDetail(
                                      product: product,
                                      redirect: true,
                                    ),
                                  ),
                                },
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: product.photo,
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                        height: 140,
                                      ),
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.fromLTRB(
                                          paddingSmall,
                                          paddingSmall,
                                          paddingSmall,
                                          0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                "${product.name}\n",
                                                overflow: TextOverflow.ellipsis,
                                                style: _theme
                                                    .textTheme.bodyText1
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Flexible(
                                              child: Text(
                                                'RM ${product.price}',
                                                overflow: TextOverflow.ellipsis,
                                                style: _theme.textTheme.caption
                                                    .copyWith(
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
                        ),
              // SizedBox(height: spacingMid),
              // Container(
              //     height: spacingSmall,
              //     color: Colors.grey[200],
              // ),
            )
          ],
        ),
      ),
    );
  }
}
