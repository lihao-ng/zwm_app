import 'package:flutter/material.dart';

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
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: SABT(
                  child: Text(
                    widget.merchant.name,
                    style: _theme.textTheme.headline3,
                  ),
                ),
                leading: IconButton(
                  icon: ClipOval(
                    child: Material(
                      color: accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(paddingSmall),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                titleSpacing: 0,
                backgroundColor: accentColor,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.asset(widget.merchant.image, fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(paddingMid),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: spacingMin),
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
                                  widget.merchant.address,
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
                                  widget.merchant.contact,
                                  style: _theme.textTheme.caption.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spacingSmall),
                          Divider(height: spacingMid, thickness: 2),
                          SizedBox(
                            height: 200,
                          ),
                          new Container(
                            decoration: new BoxDecoration(
                                color: Theme.of(context).primaryColor),
                            child: new TabBar(
                              isScrollable: true,
                              controller: _controller,
                              tabs: [
                                new Tab(
                                  icon: const Icon(Icons.home),
                                  text: 'Address',
                                ),
                                new Tab(
                                  icon: const Icon(Icons.my_location),
                                  text: 'Location',
                                ),
                                new Tab(
                                  icon: const Icon(Icons.my_location),
                                  text: 'Location',
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            height: 80.0,
                            child: new TabBarView(
                              controller: _controller,
                              children: <Widget>[
                                new Card(
                                  child: new ListTile(
                                    leading: const Icon(Icons.home),
                                    title: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Search for address...'),
                                    ),
                                  ),
                                ),
                                new Card(
                                  child: new ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: new Text(
                                        'Latitude: 48.09342\nLongitude: 11.23403'),
                                    trailing: new IconButton(
                                        icon: const Icon(Icons.my_location),
                                        onPressed: () {}),
                                  ),
                                ),
                                new Card(
                                  child: new ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: new Text(
                                        'Latitude: 48.09342\nLongitude: 11.23403'),
                                    trailing: new IconButton(
                                        icon: const Icon(Icons.my_location),
                                        onPressed: () {}),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
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
