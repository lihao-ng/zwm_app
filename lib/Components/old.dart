// runFirst() async {
//   // await Permission.locationWhenInUse.status.then(_updateStatus);

//   await _requestPerms();

//   if (_status != PermissionStatus.granted) {
//     debugPrint('if statement $_status');
//     // openAppSettings();
//     // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     // Navigator.push(
//     // context, MaterialPageRoute(builder: (context) => NextPage()));
//   } else {
//     debugPrint('else statement $_status');
//     getLocation();
//   }
//   // else if (_status == PermissionStatus.denied) {
//   //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//   // }
// }

// void _requestPerms() async {
// Map<Permission, PermissionStatus> statuses =
//     await [Permission.location].request();

// if (statuses[Permission.location] != PermissionStatus.granted) {
//   _requestPerms();
//   }

//   // if (await Permission.location.serviceStatus.isEnabled) {
//   _updateStatus(PermissionStatus.granted);
//   // if (Theme.of(context).platform == TargetPlatform.android) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: Text("Can't get gurrent location"),
//   //         content:
//   //             const Text('Please make sure you enable GPS and try again'),
//   //         actions: <Widget>[
//   //           FlatButton(
//   //             child: Text('Ok'),
//   //             onPressed: () {
//   //               final AndroidIntent intent = AndroidIntent(
//   //                   action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//   //               intent.launch();
//   //               setState(
//   //                 () {
//   //                   _status = PermissionStatus.granted;
//   //                 },
//   //               );

//   //               Navigator.of(context, rootNavigator: true).pop();
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //   },
//   // );
//   // }
//   // }
// }

// void _updateStatus(PermissionStatus value) {
//   setState(() {
//     _status = value;
//   });
// }

// void getLocation() async {
//   debugPrint('running');

// var location = new Location();

// try {
//   location.requestPermission(); //to lunch location permission popup
// } on PlatformException catch (e) {
//   if (e.code == 'PERMISSION_DENIED') {
//     print('Permission denied');
//   }
// }

// Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
// Position position = await Geolocator()
//     .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

// debugPrint('$position');
// Future.delayed(const Duration(milliseconds: 2000), () {
// setState(() {
//   _position = position;
// });

// debugPrint('running end');
// });
// }
