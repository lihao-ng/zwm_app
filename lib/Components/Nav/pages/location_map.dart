import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:zwm_app/Components/Nav/partials/location_map/FilterDialog.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:zwm_app/Models/Category.dart';
import 'package:zwm_app/Services/MapServices.dart';
import 'package:zwm_app/Services/MerchantServices.dart';

import 'package:zwm_app/Services/LocationServices.dart';
import 'package:zwm_app/Components/Nav/partials/location_map/SearchInput.dart';
import 'package:zwm_app/Models/Merchant.dart';
import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/constants.dart';
import 'package:zwm_app/utils.dart';

class LocationMap extends StatefulWidget {
  LocationMap({Key key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  // Load necessary services for Location(Permission) and Map(Markers)
  LocationServices _locationServices = new LocationServices();
  MapServices _mapServices = new MapServices();

  // For the google map to load markers and animate camera
  Set<Marker> _markers = Set();
  GoogleMapController _mapController;
  ClusterManager _clusterManager;
  List<ClusterItem<Merchant>> _clusterMerchants = List<ClusterItem<Merchant>>();

  // For the animated search bar
  double _barWidth = 160;
  bool _showSearchBar = false;

  // For the search data
  var searchController = TextEditingController();
  List<Merchant> _merchants = List<Merchant>();

  // For the filter dialog
  List<String> _selectedCategories = List<String>.generate(
      categories.length, (index) => categories[index].title);
  String _apiCalled = 'index';

  // For loading snackbar
  Flushbar flushMessage = Flushbar(
    title: "Loading",
    message: "Retrieving merchants",
    flushbarPosition: FlushbarPosition.TOP,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.easeIn,
    icon: Icon(Icons.info, color: primaryColor),
    duration: Duration(seconds: 3),
    isDismissible: false,
    leftBarIndicatorColor: primaryColor,
  );

  ClusterManager _initClusterManager() {
    return ClusterManager<Merchant>(
      _clusterMerchants,
      _updateMarkers,
      levels: [1, 3.5, 5, 8, 12, 13, 14, 15, 16],
      markerBuilder: _mapServices.markerBuilder,
      initialZoom: 11,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    if (!mounted) return;

    setState(() {
      _markers = markers;
    });
  }

  _getMerchants() async {
    if (_apiCalled != 'index') {
      _apiCalled = 'index';
    }

    flushMessage.show(context);

    MerchantServices().index(
      categories: _selectedCategories,
      search: '',
      limit: 800,
      onSuccess: (List<Merchant> merchants, page) async {
        if (!mounted) return;

        if (merchants.length == 0) {
          return;
        }

        _markers.clear();

        setState(() {
          // _markers = _mapServices.createMarkers(
          //   merchants,
          // () => _onSearchHide(),
          // );
          for (var merchant in merchants) {
            _clusterMerchants.add(
              ClusterItem(
                LatLng(merchant.lat, merchant.lng),
                item: merchant,
              ),
            );
          }

          _clusterManager.setItems(_clusterMerchants);
        });
      },
      onError: (response) {},
    );
  }

  _getNearbyMerchants(lat, lng) async {
    if (_apiCalled != 'nearby') {
      _apiCalled = 'nearby';
    }

    flushMessage.show(context);

    MerchantServices().nearby(
      categories: _selectedCategories,
      lat: lat,
      lng: lng,
      onSuccess: (List<Merchant> merchants) async {
        if (!mounted) return;

        if (merchants.length == 0) {
          return;
        }

        _clusterMerchants.clear();
        _markers.clear();

        setState(() {
          // _markers = _mapServices.createMarkers(
          //   merchants,
          //   () => _onSearchHide(),
          // );
          for (var merchant in merchants) {
            _clusterMerchants.add(
              ClusterItem(
                LatLng(merchant.lat, merchant.lng),
                item: merchant,
              ),
            );
          }

          _clusterManager.setItems(_clusterMerchants);
        });
      },
      onError: (response) {},
    );
  }

  _nearbyPosition() async {
    final givenPermission = await _locationServices.locationPermission();

    if (givenPermission == false) {
      errorAlert(
        context,
        title: "An error has occured!",
        body: 'Permission not given.',
      );
      return;
    }

    _locationServices.getLocation().then(
          (LocationData locationData) => {
            _getNearbyMerchants(locationData.latitude, locationData.longitude),
            _mapController.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(locationData.latitude, locationData.longitude),
                13.0, // Zoom factor
              ),
            ),
          },
        );
  }

  _onSearchTap(width) {
    setState(() {
      _barWidth = width;
    });

    _showSearchBar = true;
  }

  _onSearchHide() {
    setState(() {
      _barWidth = 160;
    });

    _showSearchBar = false;
  }

  void _filterSearchResults(String query) {
    MerchantServices().index(
      categories: _selectedCategories,
      search: query,
      onSuccess: (List<Merchant> merchants, page) async {
        if (!mounted) return;

        if (merchants.length == 0) {
          setState(() {
            _merchants.clear();
            _merchants.add(
              Merchant(name: 'No results found', category: '-', photo: ''),
            );
          });

          return;
        }

        setState(() {
          _merchants = merchants;
        });
      },
      onError: (response) {
        print('error');
      },
    );
  }

  _applyFilter(List<String> selectedCategories) {
    setState(() {
      _selectedCategories = selectedCategories;
    });

    if (_apiCalled == 'index') {
      _getMerchants();
    } else {
      _nearbyPosition();
    }
  }

  _setDefault() async {
    _locationServices.locationPermission();
    _clusterManager = _initClusterManager();
    await _mapServices.loadMarkerIcons();
    _getMerchants();
  }

  @override
  void initState() {
    super.initState();
    _setDefault();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(3.127887, 101.594490),
              tilt: 30.0,
              zoom: 11,
            ),
            onMapCreated: (GoogleMapController mapController) {
              _mapController = mapController;
              // print('CONTROLLER');
              // print(mapController);
              _clusterManager.setMapController(_mapController);
            },
            onCameraMove: _clusterManager.onCameraMove,
            onCameraIdle: _clusterManager.updateMap,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            markers: _markers,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedContainer(
                margin: EdgeInsets.all(paddingSmall),
                height: 60,
                width: _barWidth,
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
                                return FilterDialog(
                                  selectedCategories: _selectedCategories,
                                  applyFilter:
                                      (List<String> selectedCategories) => {
                                    _applyFilter(selectedCategories),
                                  },
                                );
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
                    itemCount: _merchants.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Keys.navKey.currentState.pushNamed(
                          '/merchant-detail',
                          arguments: _merchants[index],
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: paddingMid,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: (index % 2 == 0)
                                ? accentColor
                                : Colors.grey[100],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: _merchants[index].photo != ""
                                  ? NetworkImage(_merchants[index].photo)
                                  : AssetImage(
                                      'assets/images/home.jpg',
                                    ),
                            ),
                            title: Text(
                              _merchants[index].name,
                              style: _theme.textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              _merchants[index].category,
                              style: _theme.textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),
                          ),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          backgroundColor: primaryColor,
          foregroundColor: accentColor,
          closeManually: false,
          curve: Curves.easeIn,
          overlayOpacity: 0,
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
              onTap: () => Navigator.pushNamed(context, '/product-search'),
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
              onTap: () => _nearbyPosition(),
            ),
          ],
        ),
      ),
    );
  }
}
