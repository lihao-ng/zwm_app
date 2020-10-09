import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:readmore/readmore.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zwm_app/Components/Merchants/partials/AcceptingItemsTab.dart';
import 'package:zwm_app/Components/Merchants/partials/CouponTab.dart';
import 'package:zwm_app/Components/Merchants/partials/ProductTab.dart';
import 'package:zwm_app/Components/Merchants/partials/businessHoursDialog.dart';
import 'package:zwm_app/Models/Good.dart';

import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Services/GoodServices.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

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
  Good _good;
  List<Widget> _widgets = [];

  bool isExpaned = true;
  bool get _isAppBarExpanded {
    return _autoScrollController.hasClients &&
        _autoScrollController.offset > (160 - kToolbarHeight);
  }

  @override
  void initState() {
    print(widget.merchant.photo);
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
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

    _tabController = new TabController(length: 1, vsync: this);

    GoodServices().index(
      id: widget.merchant.id,
      onSuccess: (Good good) {
        setState(() {
          _good = good;
          _widgets = _listOfWidgets();
        });

        _tabController =
            new TabController(length: good.categories.length + 1, vsync: this);
      },
      onError: (response) {
        errorAlert(
          context,
          title: "An error has occured!",
          body: response,
        );
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        background: widget.merchant.photo != ''
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: widget.merchant.photo,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              )
            : Image.asset(
                'assets/images/home.jpg',
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
                    SizedBox(width: spacingMin),
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
                  length: _good == null ? 1 : _good.categories.length + 1,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: accentColor,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelColor: primaryColor,
                    indicatorPadding: EdgeInsets.only(left: 30, right: 30),
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [primaryColor, Colors.green[600]]),
                      borderRadius: BorderRadius.circular(50),
                      color: primaryColor,
                    ),
                    onTap: (index) async {
                      _scrollToIndex(index);
                    },
                    tabs: [
                      Tab(
                        text: 'Business Details',
                      ),
                      if (_good != null)
                        for (var category in _good.categories)
                          Tab(
                            text: category,
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

  _listOfWidgets() {
    List<Widget> widgets = [];
    var index = 0;

    for (var offer in _good.offers) {
      index += 1;

      index == 1 && _good.categories[0] == 'Rewards'
          ? widgets.add(
              _wrapScrollTag(
                index: index,
                child: CouponTab(
                  name: 'Rewards',
                  coupons: offer,
                ),
              ),
            )
          : widgets.add(
              _wrapScrollTag(
                index: index,
                child: AcceptingItemsTab(
                  name: 'Accepting Items',
                  // item: item
                ),
              ),
            );
    }

    for (var product in _good.products) {
      index += 1;

      widgets.add(
        _wrapScrollTag(
          index: index,
          child: ProductTab(
            name: _good.categories[index - 1],
            products: product,
          ),
        ),
      );
    }

    return widgets;
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
                  _wrapScrollTag(
                    index: 0,
                    child: Container(
                      color: accentColor,
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
                                    GestureDetector(
                                      onTap: () => showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BusinessHoursDialog(
                                            businessHours:
                                                widget.merchant.businessHours,
                                          );
                                        },
                                      ),
                                      child: Row(
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
                                        if (widget.merchant.contact != null)
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
                                        if (widget.merchant.link != null)
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
                                  child: widget.merchant.photo != ''
                                      ? Image.network(
                                          widget.merchant.photo,
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )
                                      : Image.asset(
                                          'assets/images/home.jpg',
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
                  Column(
                    children: _widgets,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
