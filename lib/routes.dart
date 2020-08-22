import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'package:zwm_app/screens.dart';

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
          type: PageTransitionType.fade,
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

      case '/merchant-detail':
        var merchant = settings.arguments;

        return PageTransition(
          child: MerchantDetail(merchant: merchant),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/coupons-list':
        return PageTransition(
          child: CouponsList(),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      case '/coupon-detail':
        var coupon = settings.arguments;

        return PageTransition(
          child: CouponDetail(coupon: coupon),
          type: PageTransitionType.fade,
          settings: settings,
        );
        break;

      default:
        return null;
    }
  }
}
