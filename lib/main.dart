import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:zwm_app/Utils/keys.dart';
import 'package:zwm_app/styles.dart';
import 'package:zwm_app/routes.dart';

Future main() async {
  await DotEnv().load('assets/.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ],
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      navigatorKey: Keys.navKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: '/',
    );
  }
}
