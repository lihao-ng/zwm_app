import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:zwm_app/Components/Merchants/partials/CategoryTab.dart';

import 'package:zwm_app/Components/Widgets/AppBar.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/constants.dart';

class MerchantDetail extends StatefulWidget {
  final Merchant merchant;

  const MerchantDetail({@required this.merchant});

  @override
  _MerchantDetailState createState() => _MerchantDetailState();
}

class _MerchantDetailState extends State<MerchantDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Widget _tabBarView;
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 8,
      vsync: this,
    );
    _tabBarView = TabBarView(children: [
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
      CategoryTab(),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  widget.merchant.photo != ""
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.merchant.photo,
                          fit: BoxFit.fill,
                          width: _size.width,
                          height: 200,
                        )
                      : Image.asset(
                          'assets/images/categories/bulk.jpg',
                          fit: BoxFit.fill,
                          width: _size.width,
                          height: 200,
                        ),
                  Container(
                    padding: EdgeInsets.all(paddingMid),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.merchant.name,
                          style: _theme.textTheme.headline3,
                        ),
                        SizedBox(height: spacingSmall),
                        Text(
                          widget.merchant.category,
                          style: _theme.textTheme.caption,
                        ),
                        SizedBox(height: spacingSmall),
                        Text(
                          widget.merchant.description,
                          style: _theme.textTheme.bodyText1
                              .copyWith(color: tertiaryColor),
                        ),
                        Divider(height: spacingMid, thickness: 2),
                        SizedBox(height: spacingSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ',
                              style: _theme.textTheme.caption.copyWith(
                                color: tertiaryColor,
                              ),
                            ),
                            SizedBox(width: spacingSmall),
                            Expanded(
                              child: Text(
                                widget.merchant.address != null
                                    ? widget.merchant.address
                                    : '-',
                                style: _theme.textTheme.caption.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spacingSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact: ',
                              style: _theme.textTheme.caption.copyWith(
                                color: tertiaryColor,
                              ),
                            ),
                            SizedBox(width: spacingSmall),
                            Expanded(
                              child: Text(
                                widget.merchant.contact != null
                                    ? widget.merchant.contact
                                    : '-',
                                style: _theme.textTheme.caption.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ];
          },
          controller: _scrollController,
          physics: ScrollPhysics(parent: PageScrollPhysics()),
          body: DefaultTabController(
            length: 8,
            child: Column(
              children: <Widget>[
                Container(
                  child: TabBar(
                    labelColor: primaryColor,
                    labelStyle: _theme.textTheme.bodyText1,
                    unselectedLabelColor: tertiaryColor,
                    unselectedLabelStyle: _theme.textTheme.caption,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Rewards',
                      ),
                      Tab(
                        text: 'Eggs',
                      ),
                      Tab(
                        text: 'Oats & Cereals',
                      ),
                      Tab(
                        text: 'Biscuits & Snacks',
                      ),
                      Tab(
                        text: 'Rice',
                      ),
                      Tab(
                        text: 'Noodles & Pasta',
                      ),
                      Tab(
                        text: 'Coffees, Teas & Beverages',
                      ),
                      Tab(
                        text: 'Dried Fruits',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(child: _tabBarView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
