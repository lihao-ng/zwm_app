import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zwm_app/Components/Nav/partials/location_map/SideButtons.dart';

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
  final searchController = TextEditingController();
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();

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

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
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
      // appBar: appBar(hasSideIcon: false),
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => {
                      // show dialog box
                    },
                    child: SideButtons(icon: FontAwesome.filter),
                  ),
                  SearchInput(
                      controller: searchController,
                      filter: _filterSearchResults),
                  GestureDetector(
                    onTap: () => LocationsService().locationPermission(),
                    child: SideButtons(icon: MaterialIcons.my_location),
                  ),
                ],
              ),
              if (searchController.text.toString() != '')
                Visibility(
                  visible: searchController.text.toString() != '',
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
                          // color:
                          // (index % 2 == 0) ? accentColor : Colors.grey[100],
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: (index % 2 == 0)
                                ? accentColor
                                : Colors.grey[100],
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
                      // separatorBuilder: (BuildContext context, int index) {
                      //   return SizedBox(
                      //     height: 5,
                      //   );
                      // },
                    ),
                  ),
                ),
              SizedBox(height: 20),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onMapTypeButtonPressed(),
        label: Icon(Icons.map),
      ),
    );
  }
}
