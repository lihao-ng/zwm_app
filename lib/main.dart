import 'package:flutter/material.dart';
import 'package:zwm_app/styles.dart';
import 'package:zwm_app/routes.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Montserrat",
          primarySwatch: zwmGreen,
          primaryColor: zwmGreen[900],
          accentColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline1: greenHeadline,
            headline2: whiteHeadline,
            headline3: appBarHeadline,
            bodyText1: greenBody,
            bodyText2: whiteBody,
            caption: caption,
            button: greenBtn,
          ),
        ),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: '/'
        // routes: Routes.routes(),
        );
  }
}
