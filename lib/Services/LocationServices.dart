import 'package:location/location.dart';

class LocationServices {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  locationPermission() async {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return false;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}
