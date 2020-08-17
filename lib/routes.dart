import 'package:flutter/material.dart';
import 'package:zwm_app/Components/Categories/categories.dart';
import 'package:zwm_app/Components/Merchants/merchants_list.dart';

import 'package:zwm_app/screens.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
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

      case '/qr-code':
        return PageTransition(
          child: QrCode(),
          type: PageTransitionType.downToUp,
          settings: settings,
        );
        break;

      case '/categories':
        return PageTransition(
          child: Categories(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/merchants-list':
        var category = settings.arguments;

        return PageTransition(
          child: MerchantsList(category: category),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      default:
        return null;
    }
  }
}
