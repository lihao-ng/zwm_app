import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwm_app/Components/Nav/partials/location_map/FilterDialog.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:zwm_app/Services/Permissions/LocationsService.dart';
import 'package:zwm_app/Components/Nav/partials/location_map/SearchInput.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/constants.dart';

class LocationMap extends StatefulWidget {
  LocationMap({Key key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  MapType _currentMapType = MapType.normal;
  Set<Marker> _markers = {};
  var searchController = TextEditingController();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();
  double _width = 160;
  bool _showSearchBar = false;

  void _getMerchants() async {
    BitmapDescriptor marker;
    String iconPath = 'assets/images/map_icons/';
    String icon = '';

    for (var merchant in merchants) {
      switch (merchant.category) {
        case 'Bulk Store':
          icon = 'bulk.png';
          break;

        case 'Household Products':
          icon = 'household.png';
          break;

        case 'Trift Shops':
          icon = 'thrift.png';
          break;

        case 'Personal Care Products':
          icon = 'personal_product.png';
          break;

        default:
          icon = 'recycling_centre.png';
          break;
      }

      await _getBytesFromAsset(iconPath + icon, 64)
          .then((value) => marker = BitmapDescriptor.fromBytes(value));

      _markers.add(
        Marker(
          markerId: MarkerId(merchant.id.toString()),
          position: LatLng(merchant.lat, merchant.long),
          infoWindow:
              InfoWindow(title: merchant.name, snippet: merchant.category),
          icon: marker,
          onTap: () {
            debugPrint('marker clicked: ' +
                merchant.id.toString() +
                merchant.name.toString());
          },
        ),
      );
    }

    setState(() {
      _markers = _markers;
    });
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void _onSearchTap(width) {
    setState(() {
      _width = width;
    });

    _showSearchBar = true;
  }

  void _onSearchHide() {
    setState(() {
      _width = 160;
    });

    _showSearchBar = false;
  }

  void _filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    debugPrint('controller value: ' + searchController.text);

    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });

      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    LocationsService().locationPermission();
    _getMerchants();
    items.addAll(duplicateItems);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: LatLng(3.0568, 101.585121),
              tilt: 30.0,
              zoom: 13,
            ),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            markers: _markers,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedContainer(
                margin: EdgeInsets.all(paddingSmall),
                height: 60,
                width: _width,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(paddingMid),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => {
                            _onSearchHide(),
                            showDialog(
                              context: context,
                              builder: (context) {
                                return FilterDialog();
                              },
                            ),
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                MaterialCommunityIcons.filter_variant,
                                size: 30.0,
                                color: primaryColor,
                              ),
                              SizedBox(width: spacingMin),
                              Text(
                                'Filters',
                                style: _theme.textTheme.bodyText1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(
                          width: 20,
                          thickness: 1,
                          color: captionColor,
                        ),
                        GestureDetector(
                          onTap: () => _onSearchTap(_size.width),
                          child: Icon(
                            Ionicons.ios_search,
                            size: 30.0,
                            color: primaryColor,
                          ),
                        ),
                        Visibility(
                          visible: _showSearchBar,
                          child: SearchInput(
                            controller: searchController,
                            filter: _filterSearchResults,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible:
                    searchController.text.toString() != '' && _showSearchBar,
                child: Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: paddingMid,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color:
                              (index % 2 == 0) ? accentColor : Colors.grey[100],
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/placeholder_shop.jpg'),
                          ),
                          title: Text('${items[index]}',
                              style: _theme.textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis),
                          subtitle: Text(
                            'Location here akjshdkjash aksjdha',
                            style: _theme.textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        backgroundColor: primaryColor,
        foregroundColor: accentColor,
        closeManually: false,
        curve: Curves.easeIn,
        overlayColor: captionColor,
        overlayOpacity: 0.5,
        onOpen: () => _onSearchHide(),
        children: [
          SpeedDialChild(
            child: Icon(
              MaterialIcons.store,
              color: accentColor,
            ),
            backgroundColor: Colors.orange[200],
            label: 'Search by Category',
            labelStyle: _theme.textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.bold),
            onTap: () => Navigator.pushNamed(context, '/categories'),
          ),
          SpeedDialChild(
            child: Icon(
              MaterialCommunityIcons.spray_bottle,
              color: accentColor,
            ),
            backgroundColor: Colors.lightBlue[200],
            label: 'Search by Product',
            labelStyle: _theme.textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.bold),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(
              MaterialIcons.my_location,
              color: accentColor,
            ),
            backgroundColor: Colors.redAccent[100],
            label: 'Search Nearby',
            labelStyle: _theme.textTheme.bodyText1
                .copyWith(fontWeight: FontWeight.bold),
            onTap: () => {LocationsService().locationPermission()},
          ),
        ],
      ),
    );
  }
}
