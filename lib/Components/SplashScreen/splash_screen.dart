import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zwm_app/Models/Auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _setup(context);
  }

  _setup(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //     Navigator.of(context).pushReplacementNamed('/login');
    //   });
    // });

    Auth.getInstance(onInstance: (Auth auth) {
      if (auth.accessToken == null) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/nav',
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitFoldingCube(
            color: Theme.of(context).primaryColor,
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
