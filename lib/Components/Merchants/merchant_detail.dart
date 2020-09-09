import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:readmore/readmore.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zwm_app/Components/Merchants/partials/CategoryTab.dart';

import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/constants.dart';

class MerchantDetail extends StatefulWidget {
  final Merchant merchant;

  const MerchantDetail({@required this.merchant});

  @override
  _MerchantDetailState createState() => _MerchantDetailState();
}

class _MerchantDetailState extends State<MerchantDetail>
    with TickerProviderStateMixin {
  AutoScrollController _autoScrollController;
  TabController _tabController;
  final scrollDirection = Axis.vertical;

  bool isExpaned = true;
  bool get _isAppBarExpanded {
    return _autoScrollController.hasClients &&
        _autoScrollController.offset > (160 - kToolbarHeight);
  }

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    )..addListener(
        () => _isAppBarExpanded
            ? isExpaned != false
                ? setState(
                    () {
                      isExpaned = false;
                      print('setState is called');
                    },
                  )
                : {}
            : isExpaned != true
                ? setState(() {
                    print('setState is called');
                    isExpaned = true;
                  })
                : {},
      );
    _tabController = new TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }

  Widget _wrapScrollTag({int index, Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: VisibilityDetector(
        key: Key(index.toString()),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;

          if (visiblePercentage >= 60) {
            _tabController.index = int.parse(visibilityInfo.key
                .toString()
                .replaceAll(new RegExp(r'[^0-9]'), ''));
          }
        },
        child: child,
      ),
    );
  }

  _buildSliverAppbar(ThemeData _theme) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: accentColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      automaticallyImplyLeading: false,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: accentColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: widget.merchant.photo != ""
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.merchant.photo,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              )
            : Image.asset(
                'assets/images/categories/bulk.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: isExpaned ? 0.0 : 1,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(paddingMid, paddingSmall, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.arrow_back, color: primaryColor),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          widget.merchant.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _theme.textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    paddingSmall, paddingMid, paddingSmall, paddingSmall),
                child: DefaultTabController(
                  length: 5,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: accentColor,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: primaryColor,
                    indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColor, Colors.green[300]]),
                      borderRadius: BorderRadius.circular(50),
                      color: primaryColor,
                    ),
                    // indicatorColor: Colors.transparent,
                    // indicator: ShapeDecoration(
                    //   color: primaryColor,
                    //   shape: BeveledRectangleBorder(
                    //     borderRadius: BorderRadius.circular(50),
                    //     side: BorderSide(
                    //       color: primaryColor,
                    //     ),
                    //   ),
                    // ),
                    onTap: (index) async {
                      _scrollToIndex(index);
                    },
                    tabs: [
                      Tab(
                        text: 'Detail Business',
                      ),
                      Tab(
                        text: 'Rewards',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _autoScrollController,
          slivers: <Widget>[
            _buildSliverAppbar(_theme),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: spacingSmall),
                  _wrapScrollTag(
                    index: 0,
                    child: Container(
                      padding: EdgeInsets.all(paddingMid),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.merchant.category,
                                      style: _theme.textTheme.caption.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: spacingSmall),
                                    Text(
                                      widget.merchant.name,
                                      style: _theme.textTheme.headline3,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: spacingSmall),
                                    Row(
                                      children: [
                                        Icon(
                                          Feather.clock,
                                          color: tertiaryColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: paddingMid,
                                          ),
                                          child: Text(
                                            'Business Hours',
                                            style: _theme.textTheme.caption
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: tertiaryColor,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Feather.chevron_down,
                                          color: tertiaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: spacingSmall),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RawMaterialButton(
                                          onPressed: () => _launchURL(
                                              "https://www.google.com/maps?q=loc:${widget.merchant.lat},${widget.merchant.lng}"),
                                          elevation: 5,
                                          fillColor: accentColor,
                                          child: Icon(
                                            Feather.map,
                                            color: primaryColor,
                                          ),
                                          padding: EdgeInsets.all(15),
                                          shape: CircleBorder(),
                                          constraints: BoxConstraints(),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: paddingLarge,
                                          ),
                                          child: RawMaterialButton(
                                            onPressed: () => _launchURL(
                                                "tel:${widget.merchant.contact}"),
                                            elevation: 5,
                                            fillColor: accentColor,
                                            child: Icon(
                                              Feather.phone,
                                              color: primaryColor,
                                            ),
                                            padding: EdgeInsets.all(15),
                                            shape: CircleBorder(),
                                            constraints: BoxConstraints(),
                                          ),
                                        ),
                                        RawMaterialButton(
                                          onPressed: () => _launchURL(
                                              "${widget.merchant.link}"),
                                          elevation: 5,
                                          fillColor: accentColor,
                                          child: Icon(
                                            Feather.link,
                                            color: primaryColor,
                                          ),
                                          padding: EdgeInsets.all(15),
                                          shape: CircleBorder(),
                                          constraints: BoxConstraints(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ClipOval(
                                  child: widget.merchant.photo != ""
                                      ? Image.network(
                                          widget.merchant.photo,
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )
                                      : Image.asset(
                                          'assets/images/categories/bulk.jpg',
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingLarge),
                          ReadMoreText(
                            widget.merchant.description,
                            trimLines: 6,
                            style: _theme.textTheme.bodyText1.copyWith(
                              color: tertiaryColor,
                            ),
                            colorClickableText: primaryColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...Show more',
                            trimExpandedText: ' show less',
                          ),
                        ],
                      ),
                    ),
                  ),
                  _wrapScrollTag(
                      index: 1,
                      child: CategoryTab(
                        name: 'Rewards',
                      )),
                  Container(height: spacingSmall, color: Colors.grey[200]),
                  _wrapScrollTag(
                      index: 2, child: CategoryTab(name: 'Oats & Cereals')),
                  Container(height: spacingSmall, color: Colors.grey[200]),
                  _wrapScrollTag(
                      index: 3, child: CategoryTab(name: 'Biscuits & Snacks')),
                  Container(height: spacingSmall, color: Colors.grey[200]),
                  _wrapScrollTag(index: 4, child: CategoryTab(name: 'Rice')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
