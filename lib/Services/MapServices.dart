import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart';
import 'package:zwm_app/Utils/keys.dart';

class MapServices {
  Set<Marker> _markers = {};
  List<BitmapDescriptor> _markerIcons = List<BitmapDescriptor>();

  createMarkers(merchants) {
    BitmapDescriptor marker;

    for (var merchant in merchants) {
      switch (merchant.category) {
        case 'Bulk Food':
          marker = _markerIcons[0];
          break;

        case 'Household Cleaning Product':
          marker = _markerIcons[1];
          break;

        case 'Thrift Shop (Second-hand Shop)':
          marker = _markerIcons[2];
          break;

        case 'Personal Care Product':
          marker = _markerIcons[3];
          break;

        case 'Upcycling, Recycling & Waste Disposal':
          marker = _markerIcons[4];
          break;

        case 'Community Compost Sites':
          marker = _markerIcons[5];
          break;

        case 'Repair Services':
          marker = _markerIcons[6];
          break;

        case 'Furry Friend’s Corner (Pet food and supplies)':
          marker = _markerIcons[7];
          break;

        case 'Sustainable Business & Services':
          marker = _markerIcons[8];
          break;

        case 'Traditional &amp; Wet Market':
          marker = _markerIcons[9];
          break;

        default:
          marker = _markerIcons[4];
          break;
      }

      _markers.add(
        Marker(
          markerId: MarkerId(merchant.id.toString()),
          position: LatLng(merchant.lat, merchant.lng),
          infoWindow: InfoWindow(
            title: merchant.name,
            snippet: merchant.category,
            onTap: () {
              Keys.navKey.currentState
                  .pushNamed('/merchant-detail', arguments: merchant);
            },
          ),
          icon: marker,
        ),
      );
    }

    return _markers;
  }

  loadMarkerIcons() async {
    String iconPath = 'assets/images/map_icons/';

    final icons = [
      'bulk.png',
      'household.png',
      'thrift.png',
      'personal_product.png',
      'recycling_centre.png',
      'composting.png',
      'repair_services.png',
      'furry.png',
      'sus_business.png',
      'wet_markets.png'
    ];

    for (var icon in icons) {
      await getBytesFromAsset(iconPath + icon, 64)
          .then((value) => _markerIcons.add(BitmapDescriptor.fromBytes(value)));
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
