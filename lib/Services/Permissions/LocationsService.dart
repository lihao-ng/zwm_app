import 'package:location/location.dart';

class LocationsService {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  void locationPermission() async {
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<LocationData> getLocation() async {
    return await location.getLocation();
  }
}
