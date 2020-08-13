import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:zwm_app/Services/Permissions/LocationsService.dart';

class LocationMap extends StatefulWidget {
  LocationMap({Key key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  MapType _currentMapType = MapType.normal;

  Set<Marker> _markers = {
    Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(1.toString()),
      position: LatLng(3.0568, 101.585121),
      infoWindow: InfoWindow(
        title: 'Marker ID 1',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(2.toString()),
      position: LatLng(3.1568, 101.585111),
      infoWindow: InfoWindow(
        title: 'Marker ID 2',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ),
  };

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  void initState() {
    LocationsService().locationPermission();
    super.initState();
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
              // target: LatLng(_position.latitude, _position.longitude),
              target: LatLng(3.0568, 101.585121),
              zoom: 14,
            ),
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onMapTypeButtonPressed(),
        label: Icon(Icons.map),
      ),
    );
  }
}
