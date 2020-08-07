import 'package:flutter/material.dart';
import 'package:zwm_app/screens.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static routes() {
    return {
      '/': (BuildContext context) => SplashScreen(),
      '/login': (BuildContext context) => Login(),
      '/register': (BuildContext context) {
        return PageTransition(
            child: Register(), type: PageTransitionType.downToUp);
      },
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: SplashScreen(),
          type: PageTransitionType.scale,
          settings: settings,
        );
        break;

      case '/login':
        return PageTransition(
          child: Login(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/register':
        return PageTransition(
          child: Register(),
          type: PageTransitionType.downToUp,
          settings: settings,
        );
        break;

      case '/nav':
        return PageTransition(
          child: Nav(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      default:
        return null;
    }
  }
}
